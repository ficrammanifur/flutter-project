// lib/services/chat_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ChatService {
  static const String _baseUrl = 'http://10.0.2.2:5000/api/chat'; // For Android emulator

  Future<Map<String, dynamic>> sendMessage(int userId, String message) async {
    try {
      // Handle "jadwal hari ini" request locally if possible
      if (message.toLowerCase().contains('jadwal hari ini')) {
        final now = DateTime.now();
        final dayName = DateFormat('EEEE').format(now).toLowerCase();
        
        // Map English day names to Indonesian
        final dayMap = {
          'monday': 'senin',
          'tuesday': 'selasa',
          'wednesday': 'rabu',
          'thursday': 'kamis',
          'friday': 'jumat',
          'saturday': 'sabtu',
          'sunday': 'minggu'
        };
        
        final hariIni = dayMap[dayName] ?? dayName;
        
        final response = await http.post(
          Uri.parse('$_baseUrl/today'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode({
            'user_id': userId,
            'hari': hariIni,
          }),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['schedules'] != null && data['schedules'].isNotEmpty) {
            return {
              'message': 'Berikut jadwal kuliah Anda hari ini:',
              'data': data
            };
          } else {
            return {
              'message': 'Anda tidak memiliki perkuliahan hari ini',
              'data': {'schedules': []}
            };
          }
        }
      }

      // Default case for other messages
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'user_id': userId,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to send message');
      }
    } catch (e) {
      print('Error sending message: $e');
      rethrow;
    }
  }
}