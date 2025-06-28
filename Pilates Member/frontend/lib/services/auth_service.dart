import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:frontend/models/user.dart';

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:5000'; // For Android emulator
  
  // Mock data for offline functionality
  static final List<Map<String, dynamic>> _mockUsers = [
    {
      'id': '1',
      'name': 'Afaf',
      'email': 'afaf@example.com',
      'password': 'password123',
      'phone': '+1234567890',
      'membership_type': 'Premium',
      'remaining_classes': 8,
      'membership_expiry': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      'is_active': true,
    },
    {
      'id': '2',
      'name': 'Reina',
      'email': 'rei@example.com',
      'password': 'password123',
      'phone': '+1234567891',
      'membership_type': 'Basic',
      'remaining_classes': 4,
      'membership_expiry': DateTime.now().add(const Duration(days: 15)).toIso8601String(),
      'is_active': true,
    },
  ];

  static User? _currentUser;

  static User? get currentUser => _currentUser;

  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Try to connect to backend
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          _currentUser = User.fromJson(data['user']);
          return {'success': true, 'user': _currentUser};
        } else {
          return {'success': false, 'message': data['message']};
        }
      } else {
        return {'success': false, 'message': 'Login failed'};
      }
    } catch (e) {
      // Fallback to mock data if backend is not available
      developer.log('Backend not available, using mock data: $e');
      return _mockLogin(email, password);
    }
  }

  static Map<String, dynamic> _mockLogin(String email, String password) {
    final user = _mockUsers.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      _currentUser = User.fromJson(user);
      return {'success': true, 'user': _currentUser};
    } else {
      return {'success': false, 'message': 'Invalid credentials'};
    }
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        }),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          _currentUser = User.fromJson(data['user']);
          return {'success': true, 'user': _currentUser};
        } else {
          return {'success': false, 'message': data['message']};
        }
      } else {
        return {'success': false, 'message': 'Registration failed'};
      }
    } catch (e) {
      // Fallback to mock registration
      developer.log('Backend not available, using mock registration: $e');
      return _mockRegister(name, email, password, phone);
    }
  }

  static Map<String, dynamic> _mockRegister(String name, String email, String password, String phone) {
    // Check if email already exists
    final existingUser = _mockUsers.firstWhere(
      (u) => u['email'] == email,
      orElse: () => {},
    );

    if (existingUser.isNotEmpty) {
      return {'success': false, 'message': 'Email already exists'};
    }

    // Create new user
    final newUser = {
      'id': (_mockUsers.length + 1).toString(),
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'membership_type': 'Trial',
      'remaining_classes': 1,
      'membership_expiry': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
      'is_active': true,
    };

    _mockUsers.add(newUser);
    _currentUser = User.fromJson(newUser);
    return {'success': true, 'user': _currentUser};
  }

  static Future<void> logout() async {
    _currentUser = null;
  }

  static bool isLoggedIn() {
    return _currentUser != null;
  }
}
