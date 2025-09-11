class Order {
  final String id;
  final String userId;
  final String? status;
  final double productAmount;
  final String productName;
  final String productImage;
  final int quantity;

  double get subTotal => quantity * productAmount;

  Order({
    required this.id,
    required this.userId,
    this.status,
    required this.productAmount,
    required this.productName,
    required this.productImage,
    required this.quantity,
  });
}
