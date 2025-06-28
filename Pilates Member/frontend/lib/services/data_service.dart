import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:frontend/models/user.dart';

class DataService {
  static const String baseUrl = 'http://10.0.2.2:5000';

  // Mock data for offline functionality with IDR pricing
  static final List<MembershipPackage> _mockPackages = [
    MembershipPackage(
      id: '1',
      name: 'Paket Basic',
      classes: 4,
      price: 800000.0,  // 800,000 IDR
      validityDays: 30,
      description: '4 kelas per bulan - Sempurna untuk pemula',
    ),
    MembershipPackage(
      id: '2',
      name: 'Paket Premium',
      classes: 8,
      price: 1400000.0,  // 1,400,000 IDR
      validityDays: 30,
      description: '8 kelas per bulan - Pilihan paling populer',
    ),
    MembershipPackage(
      id: '3',
      name: 'Paket Unlimited',
      classes: 999,
      price: 2000000.0,  // 2,000,000 IDR
      validityDays: 30,
      description: 'Kelas tak terbatas - Untuk praktisi yang berdedikasi',
    ),
    MembershipPackage(
      id: '4',
      name: 'Paket Trial',
      classes: 1,
      price: 250000.0,  // 250,000 IDR
      validityDays: 7,
      description: 'Coba satu kelas - Sempurna untuk pemula',
    ),
  ];

  static final List<ClassBooking> _mockBookings = [
    ClassBooking(
      id: '1',
      userId: '1',
      className: 'Morning Flow',
      scheduledTime: DateTime.now().add(const Duration(days: 1, hours: 9)),
      status: 'confirmed',
      instructor: 'Sarah Johnson',
    ),
    ClassBooking(
      id: '2',
      userId: '1',
      className: 'Evening Stretch',
      scheduledTime: DateTime.now().add(const Duration(days: 2, hours: 18)),
      status: 'confirmed',
      instructor: 'Mike Chen',
    ),
  ];

  static Future<List<MembershipPackage>> getMembershipPackages() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/packages'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['packages'] as List)
            .map((package) => MembershipPackage.fromJson(package))
            .toList();
      } else {
        throw Exception('Failed to load packages');
      }
    } catch (e) {
      developer.log('Backend not available, using mock packages: $e');
      return _mockPackages;
    }
  }

  static Future<List<ClassBooking>> getUserBookings(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/bookings/$userId'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['bookings'] as List)
            .map((booking) => ClassBooking.fromJson(booking))
            .toList();
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      developer.log('Backend not available, using mock bookings: $e');
      return _mockBookings.where((booking) => booking.userId == userId).toList();
    }
  }

  static Future<Map<String, dynamic>> bookClass({
    required String userId,
    required String className,
    required DateTime scheduledTime,
    required String instructor,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/bookings'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'class_name': className,
          'scheduled_time': scheduledTime.toIso8601String(),
          'instructor': instructor,
        }),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {'success': true, 'booking': data['booking']};
      } else {
        return {'success': false, 'message': 'Booking gagal'};
      }
    } catch (e) {
      developer.log('Backend not available, using mock booking: $e');
      // Mock booking creation
      final newBooking = ClassBooking(
        id: (_mockBookings.length + 1).toString(),
        userId: userId,
        className: className,
        scheduledTime: scheduledTime,
        status: 'confirmed',
        instructor: instructor,
      );
      _mockBookings.add(newBooking);
      return {'success': true, 'booking': newBooking};
    }
  }

  static Future<String> generateWhatsAppPaymentLink({
    required String packageName,
    required double amount,
    required String userName,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/payment/whatsapp-link'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'package_name': packageName,
          'amount': amount,
          'user_name': userName,
        }),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['whatsapp_url'];
      } else {
        throw Exception('Failed to generate WhatsApp link');
      }
    } catch (e) {
      developer.log('Backend not available, using mock WhatsApp link: $e');
      // Mock WhatsApp link generation
      final message = '''
Halo! Saya ingin membeli $packageName seharga Rp ${amount.toStringAsFixed(0)}.

Nama: $userName
Paket: $packageName
Harga: Rp ${amount.toStringAsFixed(0)}

Mohon konfirmasi pembayaran saya dan aktifkan membership saya.
Terima kasih!
''';

      final encodedMessage = Uri.encodeComponent(message);
      const phoneNumber = '6281234567890'; // Indonesian format
      
      return 'https://wa.me/$phoneNumber?text=$encodedMessage';
    }
  }
}
