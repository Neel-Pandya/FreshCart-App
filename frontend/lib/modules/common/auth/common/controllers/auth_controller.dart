import 'dart:convert';
import 'dart:core';
import 'package:frontend/core/utils/api_client.dart';
import 'package:frontend/core/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var error = ''.obs;
  var responseMessage = ''.obs;
  var user = Rxn<User>();
  final _storage = const FlutterSecureStorage();
  Future<bool> login({required String email, required String password}) async {
    isLoading.value = true;
    try {
      final response = await apiClient.post(
        'auth/login',
        data: {'email': email, 'password': password},
      );
      final user = User.fromJson(response['data']);
      await _storage.write(key: 'user', value: jsonEncode({'data': user.toJson()}));

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

  Future<bool> forgotPassword(String email) async {
    try {
      isLoading.value = true;
      final response = await apiClient.post('auth/forgot-password', data: {'email': email});
      responseMessage.value = response['message'];
      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> resetPassword(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await apiClient.post(
        'auth/reset-password',
        data: {'email': email, 'password': password},
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

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    isLoading.value = true;
    try {
      final response = await apiClient.post(
        'auth/change-password',
        data: {'oldPassword': oldPassword, 'newPassword': newPassword},
      );
      responseMessage.value = response['message'];
      _storage.delete(key: 'user');
      user.value = null;
      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> resendOtp(String email) async {
    try {
      final response = await apiClient.post('auth/resend-otp', data: {'email': email});
      responseMessage.value = response['message'];
      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
    }
  }

  Future<void> logout() async {
    await _storage.deleteAll();
    user.value = null;
  }
}
