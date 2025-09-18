import 'package:frontend/core/models/admin_product.dart';

class Order {
  final String orderId;
  final String orderDate;
  final String orderedBy;
  final double totalAmount;

  final List<Product> products;

  Order({
    required this.orderId,
    required this.orderDate,
    required this.orderedBy,
    required this.totalAmount,
    required this.products,
  });
}
