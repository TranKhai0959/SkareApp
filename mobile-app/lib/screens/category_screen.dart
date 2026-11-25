import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CategoryScreen extends StatefulWidget {
  final Function(String) onAddToCart;

  const CategoryScreen({Key? key, required this.onAddToCart}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String selectedFilter = 'Tất cả';

  final List<String> filters = [
    'Tất cả',
    'Da Dầu',
    'Mụn Level 1',
    'Mụn Level 2',
    'Da Khô Nhạy Cảm',
  ];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'CeraVe Foaming Facial Cleanser',
      'brand': 'CeraVe',
      'price': '370.000 đ',
      'oldPrice': '490.000 đ',
      'discount': '-24%',
      'skin': 'Da Dầu / Mụn Level 1',
    },
    {
      'name': 'Bioderma Sébium Gel Moussant',
      'brand': 'Bioderma',
      'price': '382.000 đ',
      'oldPrice': '560.000 đ',
      'discount': '-32%',
      'skin': 'Da Dầu / Mụn Level 2',
    },
    {
      'name': 'La Roche-Posay Effaclar Duo+M',
      'brand': 'La Roche-Posay',
      'price': '485.000 đ',
      'oldPrice': '520.000 đ',
      'discount': '-10%',
      'skin': 'Mụn Level 1',
    },
    {
      'name': 'Kiehl\'s Calendula Herbal Toner',
      'brand': 'Kiehl\'s',
      'price': '980.000 đ',
      'oldPrice': '1.100.000 đ',
      'discount': '-12%',
      'skin': 'Da Khô Nhạy Cảm',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = selectedFilter == 'Tất cả'
        ? products
        : products.where((p) => (p['skin'] as String).contains(selectedFilter)).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        title: const Text('Mỹ Phẩm Y Khoa Theo Da', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: Column(
        children: [
          // FILTER CHIPS ROW
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final f = filters[index];
                  final isSelected = f == selectedFilter;
                  return ChoiceChip(
                    label: Text(f),
                    selected: isSelected,
                    selectedColor: AppColors.primaryTeal,
                    backgroundColor: Colors.grey.shade100,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textDark,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (val) {
                      setState(() {
                        selectedFilter = f;
                      });
                    },
                  );
                },
              ),
            ),
          ),

          // PRODUCT GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final p = filtered[index];
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.borderSubtle),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/product_cerave.jpg',
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Icon(Icons.sanitizer, size: 50, color: AppColors.primaryTeal),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(color: AppColors.dangerRed, borderRadius: BorderRadius.circular(4)),
                                child: Text(p['discount'], style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(p['price'], style: const TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.w800, fontSize: 13)),
                      Text(p['oldPrice'], style: TextStyle(color: Colors.grey.shade400, fontSize: 10, decoration: TextDecoration.lineThrough)),
                      const SizedBox(height: 4),
                      Text(
                        p['name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, height: 1.2),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(4)),
                        child: Text(p['skin'], style: const TextStyle(fontSize: 9, color: Color(0xFF475569), fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: double.infinity,
                        height: 28,
                        child: ElevatedButton(
                          onPressed: () => widget.onAddToCart(p['name']),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryTeal,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          child: const Text('Thêm vào giỏ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
