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
    String categoryName = '';
    
    // Handle different category formats
    if (json['category'] == null) {
      categoryName = 'Uncategorized';
    } else if (json['category'] is Map) {
      // Category is populated as an object
      categoryName = json['category']['name'] as String? ?? 
                     json['category']['_id']?.toString() ?? 
                     'Uncategorized';
    } else if (json['category'] is String) {
      // Category is a string (could be name or ObjectId)
      categoryName = json['category'] as String;
    } else {
      // Category might be an ObjectId object, try to convert to string
      categoryName = json['category'].toString();
    }
    
    return Product(
      productId: json['_id'] as String? ?? json['productId'] as String? ?? '',
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['stock'] as int? ?? json['quantity'] as int? ?? 0,
      description: json['description'] as String,
      category: categoryName,
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
