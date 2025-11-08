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

      if (paymentMethod != 'Cash on Delivery') {
        errorMessage.value = 'Only Cash on Delivery is currently supported';
        return false;
      }

      final response = await apiClient.post(
        'orders/create',
        data: {'paymentMethod': paymentMethod, 'deliveryAddress': deliveryAddress},
      );

      responseMessage.value = response['message'];
      log('Order created successfully');

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

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiClient.get('orders/all');
      log('Orders response: $response');

      final data = response['data'] as List<dynamic>? ?? [];
      orders.value = data
          .map((orderJson) => Order.fromJson(orderJson as Map<String, dynamic>))
          .toList();

      // Sort orders by creation date (newest first)
      orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      errorMessage.value = e.toString();
      log('Failed to get orders: $e');
      orders.value = [];
    } finally {
      isLoading.value = false;
    }
  }
}
