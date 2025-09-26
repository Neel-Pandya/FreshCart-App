import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/core/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  final Dio _dio;

  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: dotenv.env['BACKEND_URL']!,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final storage = const FlutterSecureStorage();
          final stored = await storage.read(key: 'user');
          if (stored != null) {
            final decoded = jsonDecode(stored);

            final Map<String, dynamic> payload = decoded is Map<String, dynamic>
                ? (decoded['data'] is Map<String, dynamic>
                      ? decoded['data'] as Map<String, dynamic>
                      : decoded)
                : <String, dynamic>{};

            if (payload.isNotEmpty) {
              final user = User.fromJson(payload);
              if (user.accessToken.isNotEmpty) {
                options.headers['Authorization'] = 'Bearer ${user.accessToken}';
              }
            }
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  // -------------------- GET --------------------
  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Unexpected error: $e';
    }
  }

  // -------------------- POST --------------------
  Future<Map<String, dynamic>> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Unexpected error: $e';
    }
  }

  // -------------------- PUT --------------------
  Future<Map<String, dynamic>> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Unexpected error: $e';
    }
  }

  // -------------------- DELETE --------------------
  Future<Map<String, dynamic>> delete(String path, {dynamic data}) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Unexpected error: $e';
    }
  }

  // -------------------- Error Handler --------------------
  String _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return 'Server is not responding. Please try again later.';
    } else if (e.response != null && e.response?.data != null) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        // Typical JSON error
        if (data.containsKey('message')) {
          return data['message']?.toString() ?? 'Unknown server error';
        }
        // If backend uses "error" instead of "message"
        if (data.containsKey('error')) {
          return data['error']?.toString() ?? 'Unknown server error';
        }
        return 'Server error: ${e.response?.statusCode}';
      } else if (data is String) {
        // Raw string (HTML / plain text response)
        return data;
      }
      return 'Unexpected server response';
    } else if (e.type == DioExceptionType.unknown) {
      return 'No Internet connection. Please check your network.';
    } else {
      return e.message ?? 'Something went wrong';
    }
  }
}

final apiClient = ApiClient();
