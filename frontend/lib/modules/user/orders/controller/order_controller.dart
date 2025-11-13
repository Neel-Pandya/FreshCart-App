import 'dart:developer';

import 'package:frontend/core/models/order.dart';
import 'package:frontend/core/utils/api_client.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<String> errorMessage = ''.obs;
  Rx<String> responseMessage = ''.obs;
  RxList<Order> orders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<bool> createOrder(String paymentMethod, String deliveryAddress) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiClient.post(
        'orders/create',
        data: {'paymentMethod': paymentMethod, 'deliveryAddress': deliveryAddress},
      );

      responseMessage.value = response['message'];

      // Refresh orders after creating a new one
      await fetchOrders();

      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      log('Order creation failed: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Create Razorpay order - gets order ID from backend
  Future<Map<String, dynamic>?> createRazorpayOrder(String deliveryAddress) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      log('Creating Razorpay order with address: $deliveryAddress');

      final response = await apiClient.post(
        'orders/razorpay/create',
        data: {'deliveryAddress': deliveryAddress},
      );

      log('Razorpay order response: $response');

      final data = response['data'] as Map<String, dynamic>;

      return {
        'orderId': data['orderId'],
        'amount': data['amount'],
        'currency': data['currency'],
        'keyId': data['keyId'],
      };
    } catch (e) {
      log('Razorpay order creation error: $e');
      errorMessage.value = e.toString();
      log('Razorpay order creation failed: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Verify Razorpay payment - sends payment details to backend
  Future<bool> verifyRazorpayPayment({
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    required String deliveryAddress,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiClient.post(
        'orders/razorpay/verify',
        data: {
          'razorpayOrderId': razorpayOrderId,
          'razorpayPaymentId': razorpayPaymentId,
          'razorpaySignature': razorpaySignature,
          'deliveryAddress': deliveryAddress,
        },
      );

      responseMessage.value = response['message'];

      // Refresh orders after successful payment
      await fetchOrders();

      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      log('Payment verification failed: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiClient.get('orders/all');

      final data = response['data'] as List<dynamic>? ?? [];
      orders.value = data
          .map((orderJson) => Order.fromJson(orderJson as Map<String, dynamic>))
          .toList();

      // Sort orders by creation date (newest first)
      orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      errorMessage.value = e.toString();
      orders.value = [];
    } finally {
      isLoading.value = false;
    }
  }
}
