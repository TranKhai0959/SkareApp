const jwt = require('jsonwebtoken');

// Kiểm tra token đăng nhập
const verifyToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1]; // Định dạng là: "Bearer <token>"

  if (!token) {
    return res.status(401).json({ message: 'Không tìm thấy token để xác thực !!!' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded; // Lưu { user_id, email, role } vào request
    next();
  } catch (error) {
    return res.status(403).json({ message: 'Token không hợp lệ hoặc đã hết hạn !!!' });
  }
};

// Kiểm tra quyền ADMIN (dùng cho Web Admin quản lý sản phẩm/đơn hàng)
const isAdmin = (req, res, next) => {
  if (!req.user || req.user.role !== 'ADMIN') {
    return res.status(403).json({ message: 'Yêu cầu truy cập bị từ chối: Vui lòng chứng minh quyền Admin !!!' });
  }
  next();
};

module.exports = { verifyToken, isAdmin };