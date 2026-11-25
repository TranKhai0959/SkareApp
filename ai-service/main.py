import io
import os
import cv2
from fastapi import FastAPI, File, HTTPException, UploadFile
from fastapi.middleware.cors import CORSMiddleware
import numpy as np
from PIL import Image
from ultralytics import YOLO

app = FastAPI(title="SkareApp AI Skin Analysis Service", version="1.1.0")

# Cho phép gọi API từ backend/frontend nội bộ
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Đường dẫn tuyệt đối tới thư mục models
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
SKIN_MODEL_PATH = os.path.join(BASE_DIR, "models", "best_skin.pt")
ACNE_MODEL_PATH = os.path.join(BASE_DIR, "models", "best_acne.pt")

# Nạp bộ nhận diện khuôn mặt có sẵn của OpenCV
face_cascade = cv2.CascadeClassifier(
    cv2.data.haarcascades + "haarcascade_frontalface_default.xml"
)

# Nạp 2 Models thẳng vào RAM ngay khi khởi động Server
try:
  skin_model = YOLO(SKIN_MODEL_PATH)
  acne_model = YOLO(ACNE_MODEL_PATH)
  print("Hoàn tất nạp 2 Models best_skin.pt và best_acne.pt vào Ram !!!")
except Exception as e:
  print(f"Lỗi nạp model: {e}")
  raise RuntimeError("Không tìm thấy file model nào trong thư mục models/ !!!")


def detect_and_crop_face(pil_image: Image.Image) -> Image.Image:
  # Chuyển từ ảnh PIL (RGB) sang mảng OpenCV (BGR) để dò khuôn mặt
  img_np = np.array(pil_image)
  img_bgr = cv2.cvtColor(img_np, cv2.COLOR_RGB2BGR)
  gray = cv2.cvtColor(img_bgr, cv2.COLOR_BGR2GRAY)

  faces = face_cascade.detectMultiScale(
      gray, scaleFactor=1.1, minNeighbors=5, minSize=(80, 80)
  )

  if len(faces) == 0:
    raise HTTPException(
        status_code=400,
        detail=(
            "Không tìm thấy khuôn mặt trong ảnh. Vui lòng chụp chính diện và"
            " đủ sáng."
        ),
    )

  # Chọn khuôn mặt lớn nhất trong khung hình (tránh nhận nhầm mặt người đi ngang phía sau)
  x, y, w, h = max(faces, key=lambda rect: rect[2] * rect[3])

  # Mở rộng khung cắt (nới lên trên 25% để lấy trọn vùng trán)
  img_h, img_w = img_np.shape[:2]
  pad_top = int(h * 0.25)
  pad_bottom = int(h * 0.10)
  pad_side = int(w * 0.10)

  x1 = max(0, x - pad_side)
  y1 = max(0, y - pad_top)
  x2 = min(img_w, x + w + pad_side)
  y2 = min(img_h, y + h + pad_bottom)

  cropped_np = img_np[y1:y2, x1:x2]
  return Image.fromarray(cropped_np)


@app.get("/")
def root():
  return {
      "message": "SkareApp AI Service đang hoạt động. Truy cập /docs để test."
  }


@app.get("/health")
def health_check():
  return {"status": "ok", "models_loaded": ["best_skin.pt", "best_acne.pt"]}


@app.post("/analyze")
async def analyze_skin(file: UploadFile = File(...)):
  if not file.content_type or not file.content_type.startswith("image/"):
    raise HTTPException(
        status_code=400, detail="File tải lên bắt buộc phải là hình ảnh."
    )

  try:
    image_bytes = await file.read()
    raw_image = Image.open(io.BytesIO(image_bytes)).convert("RGB")
  except Exception:
    raise HTTPException(
        status_code=400, detail="Không thể đọc dữ liệu ảnh, file có thể bị hỏng."
    )

  # Tự động tìm và cắt sát khuôn mặt trước khi đưa vào 2 model AI
  face_image = detect_and_crop_face(raw_image)

  # 1. Chạy dự đoán Loại da (Dry / Normal / Oily)
  skin_results = skin_model.predict(face_image, verbose=False)[0]
  skin_top_idx = int(skin_results.probs.top1)
  skin_label = skin_results.names[skin_top_idx]
  skin_conf = round(float(skin_results.probs.top1conf) * 100, 2)
  skin_probs = {
      skin_results.names[i]: round(float(prob) * 100, 2)
      for i, prob in enumerate(skin_results.probs.data)
  }

  # 2. Chạy dự đoán Mức độ mụn (Level_0 / Level_1 / Level_2)
  acne_results = acne_model.predict(face_image, verbose=False)[0]
  acne_top_idx = int(acne_results.probs.top1)
  acne_label = acne_results.names[acne_top_idx]
  acne_conf = round(float(acne_results.probs.top1conf) * 100, 2)
  acne_probs = {
      acne_results.names[i]: round(float(prob) * 100, 2)
      for i, prob in enumerate(acne_results.probs.data)
  }

  return {
      "success": True,
      "analysis": {
          "skin_type": {
              "label": skin_label,
              "confidence": skin_conf,
              "details": skin_probs,
          },
          "acne_level": {
              "label": acne_label,
              "confidence": acne_conf,
              "details": acne_probs,
          },
      },
  }