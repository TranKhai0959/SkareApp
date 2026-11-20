import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'home_screen.dart';
import 'category_screen.dart';
import 'skin_ai_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'order_history_screen.dart';
import 'skin_history_screen.dart';
import 'menu_drawer_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final VoidCallback? onLogout;

  const MainNavigationScreen({super.key, this.onLogout});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  bool _showMenuScreen = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onSelectTab(int index) {
    setState(() {
      _showMenuScreen = false;
      _currentIndex = index;
    });
  }

  void _toggleMenuScreen() {
    setState(() {
      _showMenuScreen = !_showMenuScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        onNavigateTab: _onSelectTab,
        onOpenDrawer: _toggleMenuScreen,
      ),
      CategoryScreen(
        onAddToCart: (pName) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đã thêm "$pName" vào Giỏ hàng!')),
          );
        },
      ),
      SkinAiScreen(
        onBack: () => _onSelectTab(0),
        onGoToCart: () => _onSelectTab(3),
      ),
      CartScreen(
        onCheckoutSuccess: () => _onSelectTab(4),
      ),
      ProfileScreen(
        onLogout: () {
          widget.onLogout?.call();
        },
      ),
    ];

    Widget currentBody;
    if (_showMenuScreen) {
      // MENU SCREEN (Exact Match Hình 3)
      currentBody = MenuDrawerScreen(
        onNavigateTab: (idx) {
          setState(() {
            _showMenuScreen = false;
            _currentIndex = idx;
          });
        },
        onOpenOrderHistory: () {
          setState(() => _showMenuScreen = false);
          Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderHistoryScreen()));
        },
        onOpenSkinHistory: () {
          setState(() => _showMenuScreen = false);
          Navigator.push(context, MaterialPageRoute(builder: (_) => const SkinHistoryScreen()));
        },
        onLogout: () {
          setState(() => _showMenuScreen = false);
          widget.onLogout?.call();
        },
      );
    } else {
      currentBody = IndexedStack(
        index: _currentIndex,
        children: screens,
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      body: currentBody,
      // BOTTOM NAVIGATION BAR (Exact Match Hình 3 & Hình 4)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_rounded, 'Trang chủ'),
                _buildNavItem(1, Icons.grid_view_rounded, 'Danh mục'),

                // HIGHLIGHTED CENTER AI BUTTON (Cyan Glow, Exact Match Hình 3 & 4)
                GestureDetector(
                  onTap: () => _onSelectTab(2),
                  child: Container(
                    width: 48,
                    height: 48,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0E7490), Color(0xFF06B6D4)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: Colors.white, width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF06B6D4).withValues(alpha: 0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 22),
                  ),
                ),

                _buildNavItem(3, Icons.shopping_cart_outlined, 'Giỏ hàng'),
                _buildNavItem(4, Icons.person_outline_rounded, 'Tài khoản'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = !_showMenuScreen && _currentIndex == index;
    return GestureDetector(
      onTap: () => _onSelectTab(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 21,
              color: isSelected ? AppColors.primaryTeal : const Color(0xFF64748B),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.primaryTeal : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Also style the Drawer identical to Hình 3 if opened via gesture
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar HĐ (Hình 3)
              Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  color: Color(0xFFF59E0B),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'HĐ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 24),

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

              _buildDrawerItem(Icons.home_rounded, 'Trang Chủ', () {
                Navigator.pop(context);
                _onSelectTab(0);
              }),
              const SizedBox(height: 8),

              _buildDrawerItem(Icons.auto_awesome, 'AI Soi Da Mặt', () {
                Navigator.pop(context);
                _onSelectTab(2);
              }),
              const SizedBox(height: 8),

              _buildDrawerItem(Icons.grid_view_rounded, 'Danh Mục Mỹ Phẩm Y Khoa', () {
                Navigator.pop(context);
                _onSelectTab(1);
              }),
              const SizedBox(height: 8),

              _buildDrawerItem(Icons.inventory_2_outlined, 'Lịch Sử Đơn Hàng', () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderHistoryScreen()));
              }),
              const SizedBox(height: 8),

              _buildDrawerItem(Icons.history_rounded, 'Theo Dõi Cải Thiện Da', () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SkinHistoryScreen()));
              }),
              const SizedBox(height: 8),

              _buildDrawerItem(Icons.person_rounded, 'Cài Đặt Tài Khoản', () {
                Navigator.pop(context);
                _onSelectTab(4);
              }),
              const SizedBox(height: 14),

              _buildDrawerItem(Icons.logout_rounded, 'Đăng Xuất', () {
                Navigator.pop(context);
                widget.onLogout?.call();
              }, isDanger: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label, VoidCallback onTap, {bool isDanger = false}) {
    final textColor = isDanger ? const Color(0xFFDC2626) : const Color(0xFF1E293B);
    final borderColor = isDanger ? const Color(0xFFFECACA) : const Color(0xFFE2E8F0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
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
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
