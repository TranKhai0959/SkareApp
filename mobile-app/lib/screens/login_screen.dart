import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onLoginSuccess;
  final VoidCallback? onGoToRegister;
  final VoidCallback? onForgotPassword;

  const LoginScreen({
    super.key,
    required this.onLoginSuccess,
    this.onGoToRegister,
    this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.primaryTeal,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.spa, size: 36, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                'SKARE.VN',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primaryTeal, letterSpacing: 1),
              ),
              const SizedBox(height: 4),
              const Text(
                'Mỹ Phẩm Y Khoa & AI Soi Da Mặt',
                style: TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
              const SizedBox(height: 36),

              // EMAIL INPUT
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email tài khoản',
                  hintText: 'hieu.huynh@gmail.com',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.email_outlined, size: 20),
                ),
              ),
              const SizedBox(height: 16),

              // PASSWORD INPUT
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                ),
              ),
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    if (onForgotPassword != null) {
                      onForgotPassword!();
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                      );
                    }
                  },
                  child: const Text('Quên mật khẩu?', style: TextStyle(color: AppColors.primaryTeal, fontSize: 12)),
                ),
              ),
              const SizedBox(height: 14),

              // LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: onLoginSuccess,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTeal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('ĐĂNG NHẬP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ),
              const SizedBox(height: 12),

              // GOOGLE LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                height: 46,
                child: OutlinedButton.icon(
                  onPressed: onLoginSuccess,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.borderSubtle),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.g_mobiledata, size: 28, color: Colors.red),
                  label: const Text('Tiếp tục với tài khoản Google', style: TextStyle(color: AppColors.textDark, fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Chưa có tài khoản? ', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  GestureDetector(
                    onTap: () {
                      if (onGoToRegister != null) {
                        onGoToRegister!();
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterScreen()),
                        );
                      }
                    },
                    child: const Text(
                      'Đăng ký ngay',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryTeal),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
