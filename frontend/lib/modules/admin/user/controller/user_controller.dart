import 'package:dio/dio.dart';
import 'package:frontend/modules/admin/user/models/user.dart';
import 'package:frontend/core/utils/api_client.dart';
import 'package:dio/dio.dart' show FormData;
import 'package:get/get.dart' hide FormData;

class UserController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<String> errorMessage = ''.obs;
  Rx<String> responseMessage = ''.obs;
  RxList<User> users = <User>[].obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<bool> addUser(FormData data) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await apiClient.post('users/add', data: data);
      responseMessage.value = response['message'];
      final user = User.fromJson(response['data']);
      users.add(user);
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<User>> fetchUsers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await apiClient.get('users/all');
      final data = response['data'] as List;
      // Filter out admin and google users from the list and assign to users observable list
      users.value = data
          .map((e) => User.fromJson(e))
          .where((user) => user.role != 1)
          .where((user) => !user.isGoogle)
          .toList();
      return users;
    } catch (e) {
      errorMessage.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateUser(String userId, FormData data) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final index = users.indexWhere((user) => user.userId == userId);
      final response = await apiClient.put('users/update/$userId', data: data);
      responseMessage.value = response['message'];
      final updatedUser = User.fromJson(response['data']);
      users.removeAt(index);
      users.insert(index, updatedUser);
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteUser(String userId) async {
    try {
      errorMessage.value = '';
      final response = await apiClient.post('users/delete', data: {'id': userId});
      responseMessage.value = response['message'];
      // remove the user from the list
      users.removeWhere((user) => user.userId == userId);
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    }
  }

  Future<User?> getUserById(String userId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await apiClient.get('users/$userId');
      final user = User.fromJson(response['data']);
      return user;
    } catch (e) {
      errorMessage.value = e.toString();
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
