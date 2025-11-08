import 'package:frontend/core/models/order.dart' as common;

class AdminOrder {
  final String id;
  final String userId;
  final String userName;
  final String userEmail;
  final String userProfile;
  final List<common.OrderItem> items;
  final double totalAmount;
  final String paymentMethod;
  final String deliveryAddress;
  final DateTime createdAt;

  AdminOrder({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userProfile,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.createdAt,
  });

  factory AdminOrder.fromJson(Map<String, dynamic> json) {
    try {
      String orderId = '';
      if (json['_id'] != null) {
        orderId = json['_id'].toString();
      } else if (json['id'] != null) {
        orderId = json['id'].toString();
      }

      List<common.OrderItem> orderItems = [];
      if (json['items'] != null && json['items'] is List) {
        orderItems = (json['items'] as List<dynamic>)
            .where((item) => item != null && item is Map<String, dynamic>)
            .map((item) => common.OrderItem.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      return AdminOrder(
        id: orderId,
        userId: json['userId']?.toString() ?? '',
        userName: json['userName'] as String? ?? '',
        userEmail: json['userEmail'] as String? ?? '',
        userProfile: json['userProfile'] as String? ?? '',
        items: orderItems,
        totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
        paymentMethod: json['paymentMethod'] as String? ?? '',
        deliveryAddress: json['deliveryAddress'] as String? ?? '',
        createdAt: _parseDate(json['createdAt']),
      );
    } catch (e) {
      return AdminOrder(
        id: '',
        userId: '',
        userName: '',
        userEmail: '',
        userProfile: '',
        items: [],
        totalAmount: 0.0,
        paymentMethod: '',
        deliveryAddress: '',
        createdAt: DateTime.now(),
      );
    }
  }

  static DateTime _parseDate(dynamic dateValue) {
    if (dateValue == null) return DateTime.now();

    if (dateValue is String) {
      try {
        return DateTime.parse(dateValue);
      } catch (e) {
        return DateTime.now();
      }
    }

    if (dateValue is int) {
      return DateTime.fromMillisecondsSinceEpoch(dateValue);
    }

    return DateTime.now();
  }

  // Legacy properties for backward compatibility
  String get orderId => id;
  String get orderedBy => userName;

  // Get short formatted order ID (e.g., "Order-#A1B2")
  String get shortOrderId {
    if (id.isEmpty) return 'Order-#N/A';
    // Take first 6 characters and convert to uppercase
    final shortId = id.length > 6 ? id.substring(0, 6).toUpperCase() : id.toUpperCase();
    return 'Order-#$shortId';
  }
}
