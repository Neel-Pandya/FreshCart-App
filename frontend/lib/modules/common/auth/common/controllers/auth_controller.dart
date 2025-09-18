import 'dart:convert';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/utils/api_client.dart';
import 'package:frontend/core/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var error = ''.obs;
  var responseMessage = ''.obs;
  var user = Rxn<User>();
  Future<bool> login({required String email, required String password}) async {
    isLoading.value = true;
    try {
      final response = await apiClient.post(
        'auth/login',
        data: {'email': email, 'password': password},
      );
      final user = User.fromJson(response['data']);
      const storage = FlutterSecureStorage();
      await storage.write(key: 'user', value: jsonEncode({'data': user.toJson()}));

      this.user.value = user;
      responseMessage.value = response['message'];
      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      final response = await apiClient.post(
        'auth/signup',
        data: {'name': name, 'email': email, 'password': password},
      );
      responseMessage.value = response['message'];
      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    try {
      isLoading.value = true;
      final response = await apiClient.post('auth/verify-otp', data: {'email': email, 'otp': otp});
      responseMessage.value = response['message'];
      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    user.value = null;
  }
}
