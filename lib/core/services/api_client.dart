import 'package:dio/dio.dart';
import 'auth_service.dart';
import '../config/config.dart';

class ApiClient {
  final AuthService _authService;
  late final Dio _dio;

  ApiClient({required AuthService authService, String? baseUrl})
    : _authService = authService {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? TPSConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: _onRequest, onError: _onError),
    );
  }

  /// 🔐 Inject Firebase token automatically
  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _authService.getIdToken();
    if (token == null) {
      return handler.reject(
        DioException(requestOptions: options, message: 'Not authenticated'),
      );
    }

    options.headers['Authorization'] = 'Bearer $token';
    options.headers['Content-Type'] = 'application/json';

    handler.next(options);
  }

  void _onError(DioException error, ErrorInterceptorHandler handler) {
    // Centralized error handling
    handler.next(error);
  }

  /// GET request
  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await _dio.get(endpoint);
    return response.data as Map<String, dynamic>;
  }

  /// POST request
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.post(endpoint, data: body);
    return response.data as Map<String, dynamic>;
  }

  /// DELETE request
  Future<void> delete(String endpoint) async {
    await _dio.delete(endpoint);
  }
}
