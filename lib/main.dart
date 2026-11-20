import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const SkareApp());
}

class SkareApp extends StatefulWidget {
  const SkareApp({super.key});

  @override
  State<SkareApp> createState() => _SkareAppState();
}

class _SkareAppState extends State<SkareApp> {
  bool _isLoggedIn = false;
  final GlobalKey<ScaffoldMessengerState> _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      title: 'Skare - Mỹ Phẩm Y Khoa & AI Soi Da',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryTeal,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryTeal,
          secondary: AppColors.accentGold,
        ),
        fontFamily: 'Roboto',
      ),
      home: _isLoggedIn
          ? MainNavigationScreen(
              onLogout: () {
                setState(() {
                  _isLoggedIn = false;
                });
                _messengerKey.currentState?.showSnackBar(
                  const SnackBar(
                    content: Text('Đã đăng xuất tài khoản thành công.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            )
          : LoginScreen(
              onLoginSuccess: () {
                setState(() {
                  _isLoggedIn = true;
                });
              },
            ),
    );
  }
}
