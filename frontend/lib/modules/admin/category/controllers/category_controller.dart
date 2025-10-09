import 'package:frontend/core/utils/api_client.dart';
import 'package:frontend/core/models/category.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  var error = ''.obs;
  var responseMessage = ''.obs;
  final RxList<Category> categoryList = <Category>[].obs;

  @override
  void onInit() {
    fetchcategoryList();
    super.onInit();
  }

  Future<bool> addCategory(String name) async {
    try {
      isLoading.value = true;

      final response = await apiClient.post('category/add', data: {'name': name});
      final category = Category.fromJson(response['data']);
      categoryList.add(category);
      responseMessage.value = response['message'];
      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Category>> fetchcategoryList() async {
    try {
      isLoading.value = true;

      final response = await apiClient.get('category/all');
      final data = response['data'];

      final List<Category> categories = (data as List)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
      categoryList.value = categories;
      responseMessage.value = response['message'];
      return categoryList;
    } catch (e) {
      error.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteCategory(String id) async {
    try {
      final response = await apiClient.delete('category/delete', data: {'id': id});
      // Optimistically update the list so UI reflects instantly
      categoryList.removeWhere((c) => c.id == id);
      responseMessage.value = response['message'];
      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
    }
  }

  Future<bool> updateCategory(String id, String name) async {
    try {
      isLoading.value = true;
      final response = await apiClient.put('category/update', data: {'id': id, 'name': name});

      final index = categoryList.indexWhere((c) => c.id == id);
      if (index != -1) {
        final updatedList = [...categoryList];
        updatedList[index] = Category.fromJson(response['data']);
        categoryList.value = updatedList;
        categoryList.refresh();
      }
      responseMessage.value = response['message'];
      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
