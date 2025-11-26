import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-DB-NAME': dotenv.env['DB_NAME'] ?? ''
  };

  // --- Public Methods (Now concise wrappers) ---

  Future<T> get<T>(String endpoint, {Map<String, dynamic>? params}) {
    return _request<T>('GET', endpoint, queryParameters: params);
  }

  Future<T> post<T>(String endpoint, {Map<String, dynamic>? body}) {
    return _request<T>('POST', endpoint, body: body);
  }

  Future<T> put<T>(String endpoint, {Map<String, dynamic>? body}) {
    return _request<T>('PUT', endpoint, body: body);
  }

  Future<void> delete(String endpoint) {
    return _request<void>('DELETE', endpoint);
  }

  // --- Private Helper (The Reusable Core) ---
  Future<T> _request<T>(
      String method,
      String endpoint, {
        Map<String, dynamic>? body,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      // 1. Centralized URI Building
      final uri = Uri.parse('${dotenv.env['BASE_URL']}$endpoint').replace(
        queryParameters: queryParameters,
      );

      print('API $method: $uri');

      // 2. Prepare Request
      final headers = _headers;
      final msgBody = body != null ? json.encode(body) : null;

      http.Response response;

      // 3. Execute Method
      switch (method) {
        case 'GET':
          response = await _client.get(uri, headers: headers);
          break;
        case 'POST':
          response = await _client.post(uri, headers: headers, body: msgBody);
          break;
        case 'PUT':
          response = await _client.put(uri, headers: headers, body: msgBody);
          break;
        case 'DELETE':
          response = await _client.delete(uri, headers: headers);
          break;
        default:
          throw Exception('Method $method not supported');
      }

      // 4. Handle Response (Timeout logic can be added to the await calls above if needed)
      return _handleResponse<T>(response);

    } catch (e) {
      print('API $method Error: $e');
      rethrow;
    }
  }

  T _handleResponse<T>(http.Response response) {
    print('API Response Status: ${response.statusCode}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null as T;
      return json.decode(response.body) as T;
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'API Error: ${response.statusCode} - ${response.body}',
      );
    }
  }

  void dispose() {
    _client.close();
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() => message;
}