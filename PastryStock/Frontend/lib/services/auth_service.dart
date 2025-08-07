import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static const String baseUrl = 'http://10.0.2.2:5000/api';

  Map<String, dynamic>? _currentUser;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  Map<String, dynamic>? get currentUser => _currentUser;

  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('current_user');
      final userId = prefs.getString('user_id');

      if (userId != null && userJson != null) {
        _currentUser = json.decode(userJson);
        _isLoggedIn = true;
      }
    } catch (e) {
      await logout();
    }
  }

  Future<bool> testConnection({int retries = 3, Duration delay = const Duration(seconds: 2)}) async {
    for (int i = 0; i < retries; i++) {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/ping'),
          headers: {'Content-Type': 'application/json'},
        ).timeout(const Duration(seconds: 10));
        return response.statusCode == 200;
      } catch (e) {
        if (i < retries - 1) {
          await Future.delayed(delay);
        }
      }
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    try {
      final isConnected = await testConnection();
      if (!isConnected) {
        throw Exception('Tidak dapat terhubung ke server. Pastikan backend berjalan.');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _currentUser = data['user'];
        _isLoggedIn = true;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', _currentUser!['id']);
        await prefs.setString('current_user', json.encode(_currentUser));
        return true;
      } else {
        final error = json.decode(response.body);
        throw Exception('Login gagal: ${error['error']}');
      }
    } catch (e) {
      throw Exception('Login gagal: $e');
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      final isConnected = await testConnection();
      if (!isConnected) {
        throw Exception('Tidak dapat terhubung ke server. Pastikan backend berjalan.');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        _currentUser = data['user'];
        _isLoggedIn = true;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', _currentUser!['id']);
        await prefs.setString('current_user', json.encode(_currentUser));
        return true;
      } else {
        final error = json.decode(response.body);
        throw Exception('Pendaftaran gagal: ${error['error']}');
      }
    } catch (e) {
      throw Exception('Pendaftaran gagal: $e');
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      final isConnected = await testConnection();
      if (!isConnected) {
        throw Exception('Tidak dapat terhubung ke server. Pastikan backend berjalan.');
      }

      if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
        throw Exception('Format email tidak valid');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return true;
      } else {
        final error = json.decode(response.body);
        throw Exception('Reset kata sandi gagal: ${error['error']}');
      }
    } catch (e) {
      throw Exception('Reset kata sandi gagal: $e');
    }
  }

  Future<bool> changePassword(String newPassword) async {
    if (!_isLoggedIn || _currentUser == null) {
      throw Exception('Tidak dapat mengganti kata sandi: Pengguna belum login');
    }

    try {
      final isConnected = await testConnection();
      if (!isConnected) {
        throw Exception('Tidak dapat terhubung ke server. Pastikan backend berjalan.');
      }

      if (newPassword.length < 6) {
        throw Exception('Kata sandi harus minimal 6 karakter');
      }

      final response = await http.put(
        Uri.parse('$baseUrl/users/${_currentUser!['id']}'),
        headers: getAuthHeaders(),
        body: json.encode({'password': newPassword}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return true;
      } else {
        final error = json.decode(response.body);
        throw Exception('Gagal mengganti kata sandi: ${error['error']}');
      }
    } catch (e) {
      throw Exception('Gagal mengganti kata sandi: $e');
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_id');
      await prefs.remove('current_user');
      
      _currentUser = null;
      _isLoggedIn = false;
    } catch (e) {
      throw Exception('Logout gagal: $e');
    }
  }

  Future<bool> checkAuthStatus() async {
    if (_currentUser == null) {
      await initialize();
    }
    return _isLoggedIn;
  }

  Map<String, String> getAuthHeaders() {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (_currentUser != null && _currentUser!['id'] != null) {
      headers['X-User-ID'] = _currentUser!['id'];
    }
    return headers;
  }

  Future<bool> refreshUserData() async {
    if (!_isLoggedIn || _currentUser == null) {
      return false;
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/${_currentUser!['id']}'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        _currentUser = json.decode(response.body);
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('current_user', json.encode(_currentUser));
        return true;
      } else {
        final error = json.decode(response.body);
        throw Exception('Gagal memperbarui data pengguna: ${error['error']}');
      }
    } catch (e) {
      throw Exception('Gagal memperbarui data pengguna: $e');
    }
  }
}