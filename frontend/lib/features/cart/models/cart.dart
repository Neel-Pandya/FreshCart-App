class Cart {
  final String cartId;
  final String productName;
  final double productPrice;
  final int quantity;
  final String imageUrl;
  final String productId;

  double get totalPrice => productPrice * quantity;

  Cart({
    required this.cartId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.imageUrl,
    required this.productId,
  });
}
