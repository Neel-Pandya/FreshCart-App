class Cart {
  final String cartId;
  final String productName;
  final double productPrice;
  int quantity;
  final String imageUrl;
  final String productId;
  final int stock;

  double get totalPrice => productPrice * quantity;
  bool get hasEnoughStock => quantity <= stock;

  Cart({
    required this.cartId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.imageUrl,
    required this.productId,
    required this.stock,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cartId: json['_id'] as String? ?? '',
      productId: json['productId']['_id'] as String? ?? '',
      productName: json['productId']['name'] as String? ?? '',
      productPrice: (json['productId']['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] as int? ?? 1,
      imageUrl: json['productId']['imageUrl'] as String? ?? '',
      stock: json['productId']['stock'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'quantity': quantity};
  }
}
