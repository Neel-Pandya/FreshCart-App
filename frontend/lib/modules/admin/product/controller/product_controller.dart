import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:frontend/core/models/admin_product.dart';
import 'package:frontend/core/utils/api_client.dart';
import 'package:dio/dio.dart' show FormData;
import 'package:get/get.dart' hide FormData;

class ProductController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<String> errorMessage = ''.obs;
  Rx<String> responseMessage = ''.obs;
  RxList<Product> products = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<bool> addProduct(FormData data) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await apiClient.post('products/add', data: data);
      responseMessage.value = response['message'];
      final product = Product.fromJson(response['data']);
      products.add(product);
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Product>> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await apiClient.get('products/all');
      final data = response['data'] as List;
      products.value = data.map((e) => Product.fromJson(e)).toList();
      return products;
    } catch (e) {
      errorMessage.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateProduct(FormData data) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final productId = data.fields.first.value;
      final index = products.indexWhere((product) => product.productId == productId);
      final response = await apiClient.put('products/update', data: data);
      responseMessage.value = response['message'];
      final updatedProduct = Product.fromJson(response['data']);
      products.removeAt(index);
      products.insert(index, updatedProduct);
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      errorMessage.value = '';
      final response = await apiClient.post('products/delete', data: {'id': productId});
      responseMessage.value = response['message'];
      // remove the product from the list
      products.removeWhere((product) => product.productId == productId);
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    }
  }
}
