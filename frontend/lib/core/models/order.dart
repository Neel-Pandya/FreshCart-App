DateTime _parseDate(dynamic dateValue) {
  if (dateValue == null) return DateTime.now();

  if (dateValue is String) {
    try {
      return DateTime.parse(dateValue);
    } catch (e) {
      return DateTime.now();
    }
  }

  if (dateValue is int) {
    // Handle timestamp in milliseconds
    return DateTime.fromMillisecondsSinceEpoch(dateValue);
  }

  return DateTime.now();
}

class OrderItem {
  final String productId;
  final String productName;
  final double price;
  final int quantity;
  final double total;
  final String imageUrl;

  const OrderItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.total,
    required this.imageUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId']?['_id']?.toString() ?? json['productId']?.toString() ?? '',
      productName: json['productName'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] as int? ?? 0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'total': total,
      'imageUrl': imageUrl,
    };
  }
}

class Order {
  final String id;
  final List<OrderItem> items;
  final double totalAmount;
  final String paymentMethod;
  final String deliveryAddress;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    try {
      // Handle order ID - could be _id or id field
      String orderId = '';
      if (json['_id'] != null) {
        orderId = json['_id'].toString();
      } else if (json['id'] != null) {
        orderId = json['id'].toString();
      }

      // Parse items safely
      List<OrderItem> orderItems = [];
      if (json['items'] != null && json['items'] is List) {
        orderItems = (json['items'] as List<dynamic>)
            .where((item) => item != null && item is Map<String, dynamic>)
            .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      return Order(
        id: orderId,
        items: orderItems,
        totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
        paymentMethod: json['paymentMethod'] as String? ?? '',
        deliveryAddress: json['deliveryAddress'] as String? ?? '',
        createdAt: _parseDate(json['createdAt']),
      );
    } catch (e) {
      // Return a default order if parsing fails
      return Order(
        id: '',
        items: [],
        totalAmount: 0.0,
        paymentMethod: '',
        deliveryAddress: '',
        createdAt: DateTime.now(),
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'deliveryAddress': deliveryAddress,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Get short formatted order ID (e.g., "Order-#A1B2")
  String get shortOrderId {
    if (id.isEmpty) return 'Order-#N/A';
    // Take first 6 characters and convert to uppercase
    final shortId = id.length > 6 ? id.substring(0, 6).toUpperCase() : id.toUpperCase();
    return 'Order-#$shortId';
  }
}
