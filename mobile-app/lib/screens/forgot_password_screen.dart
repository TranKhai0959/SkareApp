import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController(text: 'hieu.huynh@gmail.com');
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _isSent = false;
  int _countdown = 60;
  Timer? _timer;

  bool _obscureNewPass = true;
  bool _obscureConfirmPass = true;

  @override
  void dispose() {
    _timer?.cancel();
    _emailController.dispose();
    _otpController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() {
      _isSent = true;
      _countdown = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        if (_countdown > 1) {
          setState(() {
            _countdown--;
          });
        } else {
          setState(() {
            _countdown = 0;
          });
          timer.cancel();
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textDark, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Khôi Phục Mật Khẩu',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),

              // ICON CONTAINER
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2FE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.lock_reset_rounded,
                  size: 36,
                  color: AppColors.primaryTeal,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                _isSent ? 'Xác Nhận & Đặt Lại' : 'Quên Mật Khẩu?',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),

              Text(
                _isSent
                    ? 'Nhập mã xác nhận 6 chữ số đã được gửi qua email của bạn để tiến hành thiết lập mật khẩu mới.'
                    : 'Đừng lo lắng! Vui lòng nhập địa chỉ email đã đăng ký. Chúng tôi sẽ gửi mã xác nhận khôi phục vào hòm thư của bạn.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppColors.textMuted,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 24),

              if (!_isSent) ...[
                // BƯỚC 1: NHẬP EMAIL
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email tài khoản',
                    hintText: 'hieu.huynh@gmail.com',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    prefixIcon: const Icon(Icons.email_outlined, size: 20),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  ),
                ),
                const SizedBox(height: 20),

                // NÚT GỬI MÃ
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      _startCountdown();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đã gửi mã xác thực gồm 6 số tới email của bạn!'),
                          backgroundColor: AppColors.primaryTeal,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryTeal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'GỬI MÃ XÁC NHẬN QUA EMAIL',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                    ),
                  ),
                ),
              ] else ...[
                // BƯỚC 2: THÔNG BÁO GỬI THÀNH CÔNG + Ô NHẬP XÁC NHẬN
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFBBF7D0)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.mark_email_read_outlined, size: 28, color: Color(0xFF16A34A)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Đã gửi mã tới email:',
                              style: TextStyle(fontSize: 11.5, color: Color(0xFF15803D)),
                            ),
                            Text(
                              _emailController.text.isNotEmpty ? _emailController.text : 'hieu.huynh@gmail.com',
                              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: Color(0xFF166534)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isSent = false;
                            _timer?.cancel();
                          });
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: const Text(
                          'Đổi email',
                          style: TextStyle(fontSize: 11.5, color: AppColors.primaryTeal, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Ô NHẬP MÃ XÁC NHẬN
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mã xác nhận (OTP)',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 8),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: '------',
                    hintStyle: const TextStyle(letterSpacing: 8, color: Colors.grey),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    prefixIcon: const Icon(Icons.pin_outlined, size: 20),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                ),
                const SizedBox(height: 8),

                // BỘ ĐẾM NGƯỢC 60 GIÂY
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_countdown > 0) ...[
                      const Icon(Icons.timer_outlined, size: 16, color: Color(0xFFD97706)),
                      const SizedBox(width: 5),
                      Text(
                        'Gửi lại mã sau: ${_countdown}s',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD97706),
                        ),
                      ),
                    ] else ...[
                      TextButton.icon(
                        onPressed: () {
                          _startCountdown();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Đã gửi lại mã xác thực mới tới email!'),
                              backgroundColor: AppColors.primaryTeal,
                            ),
                          );
                        },
                        icon: const Icon(Icons.refresh, size: 17, color: AppColors.primaryTeal),
                        label: const Text(
                          'Gửi lại mã xác nhận',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryTeal,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),

                // Ô NHẬP MẬT KHẨU MỚI
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mật khẩu mới',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _newPassController,
                  obscureText: _obscureNewPass,
                  decoration: InputDecoration(
                    hintText: 'Nhập mật khẩu mới',
                    hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    prefixIcon: const Icon(Icons.lock_outline, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNewPass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureNewPass = !_obscureNewPass;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                ),
                const SizedBox(height: 14),

                // Ô XÁC NHẬN LẠI MẬT KHẨU MỚI
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Xác nhận lại mật khẩu',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _confirmPassController,
                  obscureText: _obscureConfirmPass,
                  decoration: InputDecoration(
                    hintText: 'Nhập lại mật khẩu mới',
                    hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    prefixIcon: const Icon(Icons.lock_reset_outlined, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPass = !_obscureConfirmPass;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                ),
                const SizedBox(height: 24),

                // NÚT XÁC NHẬN VÀ ĐẶT LẠI MẬT KHẨU
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đặt lại mật khẩu thành công! Vui lòng đăng nhập lại.'),
                          backgroundColor: AppColors.primaryTeal,
                          duration: Duration(seconds: 3),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryTeal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'XÁC NHẬN & ĐẶT LẠI MẬT KHẨU',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // LIÊN KẾT QUAY LẠI ĐĂNG NHẬP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_back, size: 16, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Quay lại Đăng nhập',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryTeal),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
