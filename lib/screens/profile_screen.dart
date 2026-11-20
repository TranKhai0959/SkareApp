import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'change_password_screen.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        title: const Text('Hồ Sơ Cá Nhân', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // USER INFO CARD
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryTeal,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'HĐ',
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Huỳnh Đặng Đại Hiếu', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  const Text('hieu.huynh@gmail.com | 0912 345 678', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F2FE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Hồ Sơ Y Khoa: Da Dầu Level 1',
                      style: TextStyle(color: Color(0xFF0369A1), fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // SETTINGS OPTIONS
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildOptionTile(Icons.location_on_outlined, 'Địa chỉ giao hàng', () {}),
                  const Divider(height: 1, indent: 50),
                  _buildOptionTile(Icons.lock_outline, 'Đổi mật khẩu', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
                    );
                  }),
                  const Divider(height: 1, indent: 50),
                  _buildOptionTile(Icons.shield_outlined, 'Chính sách bảo mật y khoa', () {}),
                  const Divider(height: 1, indent: 50),
                  _buildOptionTile(Icons.logout, 'Đăng xuất', onLogout, isDestructive: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? AppColors.dangerRed : AppColors.primaryTeal, size: 20),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isDestructive ? AppColors.dangerRed : AppColors.textDark,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }
}
