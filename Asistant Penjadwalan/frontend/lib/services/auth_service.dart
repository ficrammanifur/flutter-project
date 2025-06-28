// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:5000'; // For Android emulator
  // Use 'http://localhost:5000' for iOS simulator
  // Use your actual server IP for physical devices

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signin'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email.trim(),
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'status': 'success',
          'message': responseData['message'] ?? 'Login berhasil',
          'data': responseData['data'] ?? {},
        };
      } else {
        throw Exception(responseData['message'] ?? 'Gagal login. Status ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      print('Network error: $e');
      throw Exception('Tidak dapat terhubung ke server. Periksa koneksi internet Anda.');
    } on FormatException catch (e) {
      print('JSON parsing error: $e');
      throw Exception('Respons server tidak valid.');
    } catch (e) {
      print('Login error: $e');
      throw Exception('Terjadi kesalahan saat login: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> signUp(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name.trim(),
          'email': email.trim(),
          'password': password,
        }),
      );

      print('Signup response status: ${response.statusCode}');
      print('Signup response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          'status': 'success',
          'message': responseData['message'] ?? 'Pendaftaran berhasil',
          'data': responseData['data'] ?? {},
        };
      } else {
        throw Exception(responseData['message'] ?? 'Gagal daftar. Status ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      print('Network error: $e');
      throw Exception('Tidak dapat terhubung ke server. Periksa koneksi internet Anda.');
    } on FormatException catch (e) {
      print('JSON parsing error: $e');
      throw Exception('Respons server tidak valid.');
    } catch (e) {
      print('Signup error: $e');
      throw Exception('Terjadi kesalahan saat daftar: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forgot-password'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email.trim(),
        }),
      );

      print('Forgot password response status: ${response.statusCode}');
      print('Forgot password response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'status': 'success',
          'message': responseData['message'] ?? 'Link reset password berhasil dikirim',
        };
      } else {
        throw Exception(responseData['message'] ?? 'Gagal mengirim link reset');
      }
    } on http.ClientException catch (e) {
      print('Network error: $e');
      throw Exception('Tidak dapat terhubung ke server. Periksa koneksi internet Anda.');
    } on FormatException catch (e) {
      print('JSON parsing error: $e');
      throw Exception('Respons server tidak valid.');
    } catch (e) {
      print('Forgot password error: $e');
      throw Exception('Terjadi kesalahan saat mengirim link reset: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> checkServerHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: {'Accept': 'application/json'},
      );

      print('Health check response status: ${response.statusCode}');
      print('Health check response body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Server health check failed');
      }
    } on http.ClientException catch (e) {
      print('Network error: $e');
      throw Exception('Tidak dapat terhubung ke server.');
    } on FormatException catch (e) {
      print('JSON parsing error: $e');
      throw Exception('Respons server tidak valid.');
    } catch (e) {
      print('Health check error: $e');
      throw Exception('Failed to check server health: ${e.toString()}');
    }
  }

  // Method untuk validasi email
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Method untuk validasi password
  bool isValidPassword(String password) {
    return password.length >= 6;
  }
}