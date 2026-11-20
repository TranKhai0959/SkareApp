import 'package:flutter/material.dart';
import '../constants/colors.dart';

class SkinHistoryScreen extends StatelessWidget {
  const SkinHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        title: const Text('Nhật Ký Cải Thiện Da AI', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          _buildTimelineCard(
            date: '02/11/2026 (Hôm nay)',
            skinType: 'Da Dầu / Hỗn Hợp Thiên Dầu',
            acneLevel: 'Level 1 (Mụn cám, sợi bã nhờn)',
            confidence: '96.8%',
            progressNote: 'Giảm 45% mụn cám sau 2 tuần dùng Sữa rửa mặt BHA & Serum Niacinamide.',
            isPositive: true,
          ),
          const SizedBox(height: 12),
          _buildTimelineCard(
            date: '15/10/2026',
            skinType: 'Da Dầu / Tăng Tiết Bã Nhờn',
            acneLevel: 'Level 2 (Mụn bọc sưng đỏ vùng má)',
            confidence: '95.4%',
            progressNote: 'Khởi tạo phác đồ ban đầu: Kháng viêm và làm sạch sâu dịu nhẹ.',
            isPositive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard({
    required String date,
    required String skinType,
    required String acneLevel,
    required String confidence,
    required String progressNote,
    required bool isPositive,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: isPositive ? AppColors.successGreen : AppColors.dangerRed, width: 4),
          top: const BorderSide(color: AppColors.borderSubtle),
          right: const BorderSide(color: AppColors.borderSubtle),
          bottom: const BorderSide(color: AppColors.borderSubtle),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primaryTeal)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: const Color(0xFF15803D), borderRadius: BorderRadius.circular(10)),
                child: Text('Tin cậy $confidence', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Loại da: $skinType', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text('Cấp độ mụn: $acneLevel', style: const TextStyle(fontSize: 12, color: Color(0xFFDC2626), fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isPositive ? const Color(0xFFF0FDF4) : const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(isPositive ? Icons.check_circle : Icons.info, size: 16, color: isPositive ? AppColors.successGreen : AppColors.dangerRed),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    progressNote,
                    style: TextStyle(fontSize: 11, color: isPositive ? const Color(0xFF166534) : const Color(0xFF991B1B)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
