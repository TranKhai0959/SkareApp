import 'package:flutter/material.dart';
import '../constants/colors.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigateTab;
  final VoidCallback onOpenDrawer;

  const HomeScreen({
    super.key,
    required this.onNavigateTab,
    required this.onOpenDrawer,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(62),
        child: Container(
          color: AppColors.primaryTeal,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Row(
                children: [
                  // Menu Drawer Button
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white, size: 24),
                    onPressed: onOpenDrawer,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),

                  // Search input pill
                  Expanded(
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm mỹ phẩm, CeraVe...',
                          hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                          prefixIcon: const Icon(Icons.search, size: 18, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 9),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Right Action Icons (Hình 4: QR, Location, Package, Cart with badge)
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 20),
                    onPressed: () => onNavigateTab(2), // Jump to AI Scan
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 10),

                  IconButton(
                    icon: const Icon(Icons.location_on_outlined, color: Colors.white, size: 20),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 10),

                  // Delivery / Package box icon (Hình 4)
                  IconButton(
                    icon: const Icon(Icons.inventory_2_outlined, color: Colors.white, size: 20),
                    onPressed: () => onNavigateTab(3),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 10),

                  // Cart with badge 2 (Hình 4)
                  GestureDetector(
                    onTap: () => onNavigateTab(3),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 22),
                        Positioned(
                          right: -6,
                          top: -5,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: AppColors.accentRose,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              '2',
                              style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.w800),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HERO PROMOTION BANNER (Exact Match Hình 4)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryTeal,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryTeal.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cyan rounded badge (Hình 4)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF67E8F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'DEAL SỐC 2K 3K',
                      style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF082F49)),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Title (Hình 4)
                  const Text(
                    'CN 351 T. ĐỒNG THÁP',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                  const SizedBox(height: 3),

                  // Time sub (Hình 4)
                  const Text(
                    '18H - 22H | 02.11 - 08.11',
                    style: TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                  const SizedBox(height: 12),

                  // White pill button with camera icon (Hình 4)
                  ElevatedButton.icon(
                    onPressed: () => onNavigateTab(2), // Jump to AI Screen
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryTeal,
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    ),
                    icon: const Icon(Icons.camera_alt, size: 15, color: Color(0xFF082F49)),
                    label: const Text(
                      'Thử Soi Da AI',
                      style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: Color(0xFF082F49)),
                    ),
                  ),
                ],
              ),
            ),

            // 10 CATEGORY CIRCLES GRID (Exact Match Hình 4)
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
              child: Column(
                children: [
                  // Row 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategoryCircle('Danh Mục', Icons.grid_view_rounded, const Color(0xFF10B981), () => onNavigateTab(1)),
                      _buildCategoryCircle('Hàng Mới', Icons.fiber_new_rounded, const Color(0xFFF97316), () => onNavigateTab(1)),
                      _buildCategoryCircle('Giá Rẻ\nĐộc Quyền', Icons.percent_rounded, const Color(0xFFF59E0B), () => onNavigateTab(1)),
                      _buildCategoryCircle('Sản Phẩm\nCao Cấp', Icons.diamond_rounded, const Color(0xFF8B5CF6), () => onNavigateTab(1)),
                      _buildCategoryCircle('Hỗ Trợ', Icons.headset_mic_rounded, const Color(0xFF06B6D4), () {}),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Row 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategoryCircle('Phụ Kiện\nĐiện Tử', Icons.power_rounded, const Color(0xFF3B82F6), () {}),
                      _buildCategoryCircle('Gia Dụng', Icons.home_rounded, const Color(0xFF22C55E), () {}),
                      _buildCategoryCircle('Balo &\nTúi Xách', Icons.shopping_bag_rounded, const Color(0xFF14B8A6), () {}),
                      _buildCategoryCircle('Đặt Hẹn', Icons.event_available_rounded, const Color(0xFF0EA5E9), () {}),
                      _buildCategoryCircle('Nước Hoa', Icons.sanitizer_rounded, const Color(0xFF6366F1), () {}),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // FLASH DEALS BAR (Exact Match Hình 4: Rose Pink Header)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFFF43F5E), // K-Beauty Rose Coral
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Flash deals',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
                      ),
                      const SizedBox(width: 8),
                      _buildTimerBadge('02'),
                      const Text(' : ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70)),
                      _buildTimerBadge('49'),
                      const Text(' : ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70)),
                      _buildTimerBadge('41'),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => onNavigateTab(1),
                    child: const Text(
                      'Xem tất cả >',
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // FLASH DEALS PRODUCT HORIZONTAL LIST WITH "MUA NGAY" BUTTON (Exact Match Hình 4)
            Container(
              width: double.infinity,
              color: const Color(0xFFF8FAFC),
              height: 275,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _buildProductCard(
                    title: 'CeraVe Foaming Cleanser 200ml Da...',
                    price: '370.000 đ',
                    originalPrice: '490.000 đ',
                    discount: '-24%',
                    imageAsset: 'assets/images/product_cerave.jpg',
                    onBuy: () => onNavigateTab(3),
                  ),
                  _buildProductCard(
                    title: 'Bioderma Sébium Gel Moussant Trị Mụn',
                    price: '382.000 đ',
                    originalPrice: '560.000 đ',
                    discount: '-32%',
                    imageAsset: 'assets/images/product_cerave.jpg',
                    onBuy: () => onNavigateTab(3),
                  ),
                  _buildProductCard(
                    title: 'Nước Tẩy Trang Bioderma Micell...',
                    price: '238.000 đ',
                    originalPrice: '280.000 đ',
                    discount: '-15%',
                    imageAsset: 'assets/images/product_cerave.jpg',
                    onBuy: () => onNavigateTab(3),
                  ),
                ],
              ),
            ),

            // Scroll indicator bar matching Hình 4
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.arrow_left, size: 20, color: Colors.grey),
                  Expanded(
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade600,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_right, size: 20, color: Colors.grey),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCircle(String label, IconData icon, Color bg, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 65,
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: AppColors.textDark, fontWeight: FontWeight.w600, height: 1.15),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
      ),
    );
  }

  Widget _buildProductCard({
    required String title,
    required String price,
    required String originalPrice,
    required String discount,
    required String imageAsset,
    required VoidCallback onBuy,
  }) {
    return Container(
      width: 142,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + discount badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 105,
                  width: double.infinity,
                  color: const Color(0xFFF8FAFC),
                  child: Image.asset(
                    imageAsset,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(Icons.sanitizer, size: 40, color: AppColors.primaryTeal),
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF43F5E),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    discount,
                    style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Price
          Text(
            price,
            style: const TextStyle(color: Color(0xFFE11D48), fontWeight: FontWeight.w800, fontSize: 13),
          ),

          // Old price crossed out
          Text(
            originalPrice,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 10, decoration: TextDecoration.lineThrough),
          ),
          const SizedBox(height: 3),

          // Title
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10.5, color: AppColors.textDark, fontWeight: FontWeight.w600, height: 1.25),
          ),
          const Spacer(),

          // Button "Mua ngay" (Exact Match Hình 4)
          SizedBox(
            width: double.infinity,
            height: 28,
            child: ElevatedButton(
              onPressed: onBuy,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryTeal,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: const Text(
                'Mua ngay',
                style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
