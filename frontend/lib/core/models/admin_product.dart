class Product {
  final String imageUrl;
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String description;
  final String category;

  Product({
    required this.imageUrl,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['_id'] as String? ?? '',
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['stock'] as int,
      description: json['description'] as String,
      category: json['category'] is Map
          ? json['category']['name'] as String
          : json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'productId': productId,
      'name': name,
      'price': price,
      'stock': quantity,
      'description': description,
      'category': category,
    };
  }
}
