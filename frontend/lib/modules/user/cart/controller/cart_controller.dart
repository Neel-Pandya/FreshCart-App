import 'package:frontend/core/utils/api_client.dart';
import 'package:frontend/modules/user/cart/models/cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<bool> isFetching = false.obs;
  Rx<String> errorMessage = ''.obs;
  Rx<String> responseMessage = ''.obs;
  RxList<Cart> cartItems = <Cart>[].obs;

  Future<bool> addToCart(String productId, int quantity) async {
    try {
      errorMessage.value = '';
      final response = await apiClient.post(
        'cart/add',
        data: {'productId': productId, 'quantity': quantity},
      );
      responseMessage.value = response['message'];
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    }
  }

  Future<List<Cart>> getCart() async {
    try {
      isFetching.value = true;
      errorMessage.value = '';
      final response = await apiClient.get('cart/all');

      if (response['data'] is List) {
        final data = response['data'] as List;
        cartItems.value = data.map((e) => Cart.fromJson(e)).toList();
      } else {
        cartItems.value = [];
      }

      return cartItems;
    } catch (e) {
      errorMessage.value = e.toString();
      return [];
    } finally {
      isFetching.value = false;
    }
  }

  Future<bool> removeFromCart(String productId) async {
    try {
      errorMessage.value = '';
      final response = await apiClient.post('cart/remove', data: {'productId': productId});
      responseMessage.value = response['message'];

      // Remove from local list
      cartItems.removeWhere((item) => item.productId == productId);

      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    }
  }

  Future<bool> updateCartQuantity(String productId, int quantity) async {
    try {
      errorMessage.value = '';
      final response = await apiClient.put(
        'cart/update-quantity',
        data: {'productId': productId, 'quantity': quantity},
      );
      responseMessage.value = response['message'];

      // Update local list
      final index = cartItems.indexWhere((item) => item.productId == productId);
      if (index != -1) {
        cartItems[index].quantity = quantity;
        cartItems.refresh();
      }

      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    }
  }

  Future<bool> clearCart() async {
    try {
      errorMessage.value = '';
      final response = await apiClient.post('cart/clear', data: {});
      responseMessage.value = response['message'];

      // Clear local list
      cartItems.value = [];

      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    }
  }

  Future<int> getCartCount() async {
    try {
      errorMessage.value = '';
      final response = await apiClient.get('cart/count');
      final count = response['data']['count'] as int;
      return count;
    } catch (e) {
      errorMessage.value = e.toString();
      return 0;
    }
  }
}
