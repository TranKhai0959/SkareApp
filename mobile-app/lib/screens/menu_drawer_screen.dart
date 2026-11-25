import 'package:flutter/material.dart';

class MenuDrawerScreen extends StatelessWidget {
  final Function(int) onNavigateTab;
  final VoidCallback onOpenOrderHistory;
  final VoidCallback onOpenSkinHistory;
  final VoidCallback onLogout;

  const MenuDrawerScreen({
    super.key,
    required this.onNavigateTab,
    required this.onOpenOrderHistory,
    required this.onOpenSkinHistory,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar HĐ (Exact Match Hình 3)
              Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  color: Color(0xFFF59E0B), // Yellow Gold
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'HĐ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title "MENU CHÍNH" (Exact Match Hình 3)
              const Text(
                'MENU CHÍNH',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF94A3B8),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 12),

              // 7 Rounded Card Menu Items (Exact Match Hình 3)
              _buildMenuItem(
                icon: Icons.home_rounded,
                label: 'Trang Chủ',
                onTap: () => onNavigateTab(0),
              ),
              const SizedBox(height: 8),

              _buildMenuItem(
                icon: Icons.auto_awesome,
                label: 'AI Soi Da Mặt',
                onTap: () => onNavigateTab(2),
              ),
              const SizedBox(height: 8),

              _buildMenuItem(
                icon: Icons.grid_view_rounded,
                label: 'Danh Mục Mỹ Phẩm Y Khoa',
                onTap: () => onNavigateTab(1),
              ),
              const SizedBox(height: 8),

              _buildMenuItem(
                icon: Icons.inventory_2_outlined,
                label: 'Lịch Sử Đơn Hàng',
                onTap: onOpenOrderHistory,
              ),
              const SizedBox(height: 8),

              _buildMenuItem(
                icon: Icons.history_rounded,
                label: 'Theo Dõi Cải Thiện Da',
                onTap: onOpenSkinHistory,
              ),
              const SizedBox(height: 8),

              _buildMenuItem(
                icon: Icons.person_rounded,
                label: 'Cài Đặt Tài Khoản',
                onTap: () => onNavigateTab(4),
              ),
              const SizedBox(height: 14),

              // Đăng Xuất (Red outline button, Exact Match Hình 3)
              _buildMenuItem(
                icon: Icons.logout_rounded,
                label: 'Đăng Xuất',
                onTap: onLogout,
                isDanger: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    final textColor = isDanger ? const Color(0xFFDC2626) : const Color(0xFF1E293B);
    final borderColor = isDanger ? const Color(0xFFFECACA) : const Color(0xFFE2E8F0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: textColor),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
