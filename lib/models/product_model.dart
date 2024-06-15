class Product {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final String category;
  final String description;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.category,
    required this.description,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      thumbnail: json['thumbnail'],
      category: json['category'],
      description: json['description'],
      images: List<String>.from(json['images']),
    );
  }
}
