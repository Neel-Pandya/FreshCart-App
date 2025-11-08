import 'dart:developer';

import 'package:frontend/core/models/admin_order.dart';
import 'package:frontend/core/utils/api_client.dart';
import 'package:get/get.dart';

class AdminOrderController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<String> errorMessage = ''.obs;
  RxList<AdminOrder> orders = <AdminOrder>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllOrders();
  }

  Future<void> fetchAllOrders() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiClient.get('orders/admin/all');
      log('Admin orders response: $response');

      final data = response['data'] as List<dynamic>? ?? [];
      orders.value = data
          .map((orderJson) => AdminOrder.fromJson(orderJson as Map<String, dynamic>))
          .toList();

      // Orders are already sorted by backend (newest first)
    } catch (e) {
      errorMessage.value = e.toString();
      log('Failed to get admin orders: $e');
      orders.value = [];
    } finally {
      isLoading.value = false;
    }
  }
}
