import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import '../config/config.dart';

/// TPS API Client
///
/// Base HTTP client with Firebase auth token injection.
class ApiClient {
  final AuthService _authService;
  final String _baseUrl;

  ApiClient({required AuthService authService, String? baseUrl})
    : _authService = authService,
      _baseUrl = baseUrl ?? TPSConfig.apiBaseUrl;

  /// Make an authenticated GET request.
  Future<Map<String, dynamic>> get(String endpoint) async {
    final token = await _authService.getIdToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  }

  /// Make an authenticated POST request.
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final token = await _authService.getIdToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: body != null ? json.encode(body) : null,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  }

  /// Make an authenticated DELETE request.
  Future<void> delete(String endpoint) async {
    final token = await _authService.getIdToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.delete(
      Uri.parse('$_baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  }
}
