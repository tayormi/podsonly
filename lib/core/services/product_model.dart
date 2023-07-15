class ProductModel {
  final int id;
  final String title;
  final String description;
  final num price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final title = data['title'] as String;
    final description = data['description'] as String;
    final price = data['price'] as num;
    final discountPercentage = data['discountPercentage'] as double;
    final rating = data['rating'] as double;
    final stock = data['stock'] as int;
    final brand = data['brand'] as String;
    final category = data['category'] as String;
    final thumbnail = data['thumbnail'] as String;
    final images = List<String>.from(data['images'] as List<dynamic>);
    return ProductModel(
      id: id,
      title: title,
      description: description,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      brand: brand,
      category: category,
      thumbnail: thumbnail,
      images: images,
    );
  }
}
