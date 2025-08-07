import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/prediction_model.dart';
import 'auth_service.dart';

class PredictionService {
  static const String baseUrl = 'http://10.0.2.2:5000/api'; // Ganti dengan IP lokal jika menggunakan perangkat fisik
  static const int maxRetries = 3;
  static const Duration timeoutDuration = Duration(seconds: 30); // Tingkatkan timeout
  final AuthService _authService = AuthService();

  Future<http.Response> _retryRequest(Future<http.Response> Function() request) async {
    int attempts = 0;
    while (attempts < maxRetries) {
      try {
        final response = await request().timeout(timeoutDuration);
        print('[DEBUG] _retryRequest: Attempt $attempts succeeded');
        return response;
      } catch (e) {
        attempts++;
        print('[DEBUG] _retryRequest: Attempt $attempts failed with error: $e');
        if (attempts == maxRetries) {
          throw Exception('Max retries reached: $e');
        }
        await Future.delayed(Duration(milliseconds: 500 * attempts));
      }
    }
    throw Exception('Unexpected error during retry');
  }

  Future<List<PredictionModel>> getStockPredictions() async {
    try {
      final headers = _authService.getAuthHeaders();
      if (!headers.containsKey('X-User-ID')) {
        print('[DEBUG] getStockPredictions: Missing X-User-ID header');
        throw Exception('User not authenticated');
      }
      print('[DEBUG] getStockPredictions: Sending request with headers $headers');
      final response = await _retryRequest(() => http.get(
        Uri.parse('$baseUrl/predictions'),
        headers: headers,
      ));
      
      print('[DEBUG] getStockPredictions: Status: ${response.statusCode}');
      print('[DEBUG] getStockPredictions: Raw response: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('[DEBUG] getStockPredictions: Parsed data: ${data.map((json) => json['ingredientName']).toList()}');
        return data.map((item) => PredictionModel.fromJson(item)).toList();
      } else {
        print('[DEBUG] getStockPredictions: Failed with status ${response.statusCode}, body: ${response.body}');
        throw Exception('Failed to load predictions: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      print('[ERROR] getStockPredictions: $e');
      throw Exception('Error fetching stock predictions: $e');
    }
  }

  Future<Map<String, dynamic>> calculateARIMAPrediction(String ingredientId) async {
    try {
      final headers = _authService.getAuthHeaders();
      if (!headers.containsKey('X-User-ID')) {
        print('[DEBUG] calculateARIMAPrediction: Missing X-User-ID header for ingredient $ingredientId');
        throw Exception('User not authenticated');
      }
      print('[DEBUG] calculateARIMAPrediction: Sending request for ingredient $ingredientId with headers $headers');
      final response = await _retryRequest(() => http.get(
        Uri.parse('$baseUrl/predictions/$ingredientId/arima'),
        headers: headers,
      ));
      
      print('[DEBUG] calculateARIMAPrediction: Status: ${response.statusCode}');
      print('[DEBUG] calculateARIMAPrediction: Raw response: ${response.body}');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('[DEBUG] calculateARIMAPrediction: Failed with status ${response.statusCode}, body: ${response.body}');
        throw Exception('Failed to load ARIMA prediction: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      print('[ERROR] calculateARIMAPrediction: $e');
      throw Exception('Error fetching ARIMA prediction for ingredient $ingredientId: $e');
    }
  }
}