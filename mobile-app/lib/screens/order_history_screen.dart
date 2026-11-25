import 'package:flutter/material.dart';
import '../constants/colors.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primaryTeal,
          title: const Text('Lịch Sử Đơn Đặt Hàng', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          elevation: 0,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: AppColors.accentGold,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Chờ duyệt (1)'),
              Tab(text: 'Đang giao (1)'),
              Tab(text: 'Hoàn thành (2)'),
              Tab(text: 'Đã hủy (0)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList([
              {
                'id': '#SKR-8821',
                'date': '02/11/2026 14:15',
                'items': '2x CeraVe Foaming Cleanser, 1x Bioderma Sébium',
                'total': '752.000 đ',
                'status': 'Chờ duyệt',
                'statusColor': AppColors.accentGold,
                'method': 'COD (Thanh toán khi nhận hàng)',
              }
            ]),
            _buildOrderList([
              {
                'id': '#SKR-8820',
                'date': '02/11/2026 13:40',
                'items': '1x CeraVe Foaming Cleanser',
                'total': '370.000 đ',
                'status': 'Đang vận chuyển',
                'statusColor': AppColors.infoBlue,
                'method': 'Chuyển khoản VietQR',
              }
            ]),
            _buildOrderList([
              {
                'id': '#SKR-8815',
                'date': '25/10/2026',
                'items': '1x La Roche-Posay Effaclar Duo+M',
                'total': '485.000 đ',
                'status': 'Đã giao thành công',
                'statusColor': AppColors.successGreen,
                'method': 'Chuyển khoản VietQR',
              }
            ]),
            const Center(child: Text('Không có đơn hàng đã hủy', style: TextStyle(color: AppColors.textMuted))),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(List<Map<String, dynamic>> orders) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final o = orders[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(o['id'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primaryTeal)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: (o['statusColor'] as Color).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      o['status'],
                      style: TextStyle(color: o['statusColor'], fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Ngày đặt: ${o['date']}', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
              const SizedBox(height: 4),
              Text('Sản phẩm: ${o['items']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text('Hình thức: ${o['method']}', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
              const SizedBox(height: 8),
              const Divider(height: 1),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tổng thanh toán:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  Text(o['total'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFFDC2626))),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
