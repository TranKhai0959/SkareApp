class Product {
  final String id;
  final String name;
  final String brand;
  final double price;
  final double originalPrice;
  final String imageUrl;
  final List<String> suitableSkinTypes; // 'Da Dầu', 'Da Khô', 'Mụn Level 1', etc.
  final String description;
  final double rating;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.suitableSkinTypes,
    required this.description,
    this.rating = 4.8,
  });

  int get discountPercentage {
    if (originalPrice <= price) return 0;
    return (((originalPrice - price) / originalPrice) * 100).round();
  }
}

class SkinAnalysisResult {
  final String skinType; // e.g., 'Da Dầu / Hỗn Hợp Thiên Dầu'
  final String acneLevel; // e.g., 'Level 1 (Mụn cám, sợi bã nhờn)'
  final String sensitiveArea; // e.g., 'Vùng chữ T (Trán, Mũi, Cằm)'
  final double confidenceScore; // e.g., 96.8
  final List<String> protocols;
  final Product recommendedProduct;
  final DateTime scannedAt;

  SkinAnalysisResult({
    required this.skinType,
    required this.acneLevel,
    required this.sensitiveArea,
    required this.confidenceScore,
    required this.protocols,
    required this.recommendedProduct,
    required this.scannedAt,
  });
}
