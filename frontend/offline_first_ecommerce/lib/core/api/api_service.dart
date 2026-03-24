import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:offline_first_ecommerce/core/service/token_service.dart';

class ApiService {
  final Dio _dio;
  final TokenService _tokenService;

  // Aapka backend URL (Localhost for Emulator)
  static const String _baseUrl = 'http://192.168.100.70:3000/api/v1';

  ApiService(this._dio, this._tokenService) {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
    _dio.options.headers['accept'] = 'application/json';

    _dio.interceptors.add(_authInterceptor());
    _dio.interceptors.add(_loggingInterceptor());
  }

  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(
      onResponse: (response, handler) => handler.next(response),
      onError: (error, handler) {
        log('❌ [${error.requestOptions.method}] Error on: ${error.requestOptions.path}');
        log('   Status: ${error.response?.statusCode} | Msg: ${error.message}');
        return handler.next(error);
      },
    );
  }

  Interceptor _authInterceptor() {
    return QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        // Skip token for login/register
        if (options.path.contains('/auth/login') || options.path.contains('/auth/register')) {
          return handler.next(options);
        }

        final token = await _tokenService.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401 && !error.requestOptions.path.contains('/auth/login')) {
          // Attempt token refresh
          final success = await _refreshToken();
          if (success) {
            // Retry original request
            final token = await _tokenService.getAccessToken();
            error.requestOptions.headers['Authorization'] = 'Bearer $token';
            final response = await _dio.fetch(error.requestOptions);
            return handler.resolve(response);
          }
        }
        return handler.next(error);
      },
    );
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _tokenService.getRefreshToken();
      if (refreshToken == null) return false;

      // Naya Dio instance taake interceptor loop na banay
      final response = await Dio().post(
        '$_baseUrl/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccess = response.data['accessToken'];
        final newRefresh = response.data['refreshToken'];
        await _tokenService.saveTokens(accessToken: newAccess, refreshToken: newRefresh);
        return true;
      }
      return false;
    } catch (e) {
      await _tokenService.clearTokens();
      // Yahan aap Navigation/Login par bhej sakte hain
      return false;
    }
  }

  // Common Methods (Get, Post etc) jese aapne likhay thay
  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    return await _dio.get(path, queryParameters: query);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }
}