import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  // Get headers
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-DB-NAME': dotenv.env['DB-NAME'] ?? ''
  };

  // GET request
  Future<T> get<T>(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      // Build URI with query parameters
      final uri = Uri.parse('${dotenv.env['BASE_URL']}$endpoint').replace(
        queryParameters: queryParameters,
      );

      final response = await _client
          .get(uri, headers: _headers)
          .timeout(const Duration(seconds: 5));

      return _handleResponse<T>(response);
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<T> post<T>(
      String endpoint, {
        Map<String, dynamic>? body,
      }) async {
    try {
      final uri = Uri.parse('${dotenv.env['BASE_URL']}$endpoint');

      print('API POST: $uri');

      final response = await _client
          .post(
        uri,
        headers: _headers,
        body: json.encode(body),
      )
          .timeout(const Duration(seconds: 5));

      return _handleResponse<T>(response);
    } catch (e) {
      print('API POST Error: $e');
      rethrow;
    }
  }

  // PUT request
  Future<T> put<T>(
      String endpoint, {
        Map<String, dynamic>? body,
      }) async {
    try {
      final uri = Uri.parse('${dotenv.env['BASE_URL']}$endpoint');

      print('API PUT: $uri');

      final response = await _client
          .put(
        uri,
        headers: _headers,
        body: json.encode(body),
      )
          .timeout(const Duration(seconds: 5));

      return _handleResponse<T>(response);
    } catch (e) {
      print('API PUT Error: $e');
      rethrow;
    }
  }

  // DELETE request
  Future<void> delete(String endpoint) async {
    try {
      final uri = Uri.parse('${dotenv.env['BASE_URL']}$endpoint');

      print('API DELETE: $uri');

      final response = await _client
          .delete(uri, headers: _headers)
          .timeout(const Duration(seconds: 5));

      return _handleResponse<void>(response);
    } catch (e) {
      print('API DELETE Error: $e');
      rethrow;
    }
  }

  /// Handle API response with generic type
  ///
  /// Parses response and returns type [T]
  /// Throws [ApiException] on error
  T _handleResponse<T>(http.Response response) {
    print('API Response Status: ${response.statusCode}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Handle empty response for DELETE operations
      if (response.body.isEmpty) {
        return null as T;
      }

      // Parse JSON response
      final decoded = json.decode(response.body);
      return decoded as T;
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'API Error: ${response.statusCode} - ${response.body}',
      );
    }
  }

  // Close client
  void dispose() {
    _client.close();
  }
}

// Custom API Exception
class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({
    required this.statusCode,
    required this.message,
  });

  @override
  String toString() => message;
}