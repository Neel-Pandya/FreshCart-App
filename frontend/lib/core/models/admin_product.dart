class Product {
  final String imageUrl;
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String description;
  final String category;

  double get subTotal => price * quantity;

  Product({
    required this.imageUrl,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.category,
  });
}
