import 'package:flutter/material.dart';
import '../constants/colors.dart';

class SkinAiScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onGoToCart;

  const SkinAiScreen({
    Key? key,
    required this.onBack,
    required this.onGoToCart,
  }) : super(key: key);

  @override
  State<SkinAiScreen> createState() => _SkinAiScreenState();
}

class _SkinAiScreenState extends State<SkinAiScreen> {
  bool isScanning = false;
  String currentSkinType = 'Da Dầu / Hỗn Hợp Thiên Dầu';
  String currentAcneLevel = 'Level 1 (Mụn cám, sợi bã nhờn)';
  String currentSensitiveArea = 'Vùng chữ T (Trán, Mũi, Cằm)';
  String currentConfidence = '96.8%';
  List<String> currentProtocols = [
    'Làm sạch sâu với sữa rửa mặt BHA/Salicylic Acid.',
    'Kiểm soát dầu thừa bằng Serum Niacinamide 10%.',
    'Dưỡng ẩm dạng gel mỏng nhẹ không bít tắc lỗ chân lông.'
  ];

  void _triggerScanSimulation() {
    setState(() {
      isScanning = true;
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      setState(() {
        isScanning = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('YOLOv8: Phân tích tế bào sừng và bã nhờn hoàn tất!'),
          backgroundColor: AppColors.primaryTeal,
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: widget.onBack,
        ),
        title: const Text(
          'AI Soi Da & Chẩn Đoán Y Khoa',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CAMERA PREVIEW WITH YOLOv8 OVAL (Image 3)
            Container(
              margin: const EdgeInsets.all(12),
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 4)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/face_scan.jpg',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.face, size: 100, color: Colors.white30),
                    ),

                    // GREEN DASHED OVAL FOR YOLOv8 FACE TRACKING
                    Container(
                      width: 155,
                      height: 195,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(95),
                        border: Border.all(
                          color: isScanning ? AppColors.accentGold : AppColors.successGreen,
                          width: 2.2,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),

                    // TRACKING BADGE
                    Positioned(
                      top: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF15803D),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 4)],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(color: Color(0xFF4ADE80), shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              isScanning ? 'Đang phân tích AI...' : 'YOLOv8 Face Tracking',
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ACTION BUTTONS (Image 3)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: isScanning ? null : _triggerScanSimulation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentGold,
                        foregroundColor: const Color(0xFF1E293B),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.camera_alt, size: 18),
                      label: Text(
                        isScanning ? 'Đang quét...' : 'Chụp & Quét AI',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tính năng chọn ảnh từ thư viện thiết bị')),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1E293B),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.file_upload_outlined, size: 18),
                      label: const Text(
                        'Tải ảnh từ máy',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // DIAGNOSIS RESULT CARD (Image 3)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: const Border(
                  left: BorderSide(color: AppColors.successGreen, width: 4),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CARD TITLE & CONFIDENCE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.bar_chart_rounded, color: AppColors.primaryTeal, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Kết Quả Chẩn Đoán YOLOv8',
                            style: TextStyle(color: AppColors.primaryTeal, fontWeight: FontWeight.w800, fontSize: 13),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF15803D),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Tin cậy $currentConfidence',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  _buildDiagRow('Loại da:', currentSkinType, isRed: true),
                  _buildDiagRow('Cấp độ mụn:', currentAcneLevel),
                  _buildDiagRow('Vùng nhạy cảm:', currentSensitiveArea),

                  const SizedBox(height: 10),
                  const Divider(height: 1, color: AppColors.borderSubtle),
                  const SizedBox(height: 10),

                  // TREATMENT PROTOCOL
                  const Text(
                    'Phác đồ chăm sóc đề xuất:',
                    style: TextStyle(color: AppColors.primaryTeal, fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: currentProtocols
                        .map((step) => Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('• ', style: TextStyle(color: AppColors.primaryTeal, fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: Text(
                                      step,
                                      style: const TextStyle(fontSize: 11, color: Color(0xFF475569), height: 1.3),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 12),

                  // RECOMMENDED PRODUCT
                  const Text(
                    'Sản phẩm phù hợp gợi ý:',
                    style: TextStyle(color: AppColors.primaryTeal, fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            width: 40,
                            height: 40,
                            color: Colors.white,
                            child: Image.asset(
                              'assets/images/product_cerave.jpg',
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Icon(Icons.sanitizer, color: AppColors.primaryTeal),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'CeraVe Foaming Cleanser',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textDark),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '370.000 đ',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFFDC2626)),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: widget.onGoToCart,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryTeal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            minimumSize: const Size(60, 28),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          child: const Text('Mua ngay', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagRow(String label, String value, {bool isRed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isRed ? const Color(0xFFDC2626) : AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
