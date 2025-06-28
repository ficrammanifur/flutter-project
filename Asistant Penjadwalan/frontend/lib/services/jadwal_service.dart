import 'dart:convert';
import 'package:http/http.dart' as http;

class JadwalService {
  static const String _baseUrl = 'http://10.0.2.2:5000';
  final Map<String, String> _hariMapping = {
    'Monday': 'Senin',
    'Tuesday': 'Selasa',
    'Wednesday': 'Rabu',
    'Thursday': 'Kamis',
    'Friday': 'Jumat',
    'Saturday': 'Sabtu',
    'Sunday': 'Minggu',
  };
  final List<String> _hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];

  Future<List<dynamic>> dapatkanJadwal(int userId) async {
    try {
      print('🔍 Fetching all schedules for user: $userId');
      final response = await http.get(
        Uri.parse('$_baseUrl/jadwal/$userId'),
        headers: {'Accept': 'application/json'},
      );

      print('📡 Response status: ${response.statusCode}');
      print('📡 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          final schedules = data['data'] ?? [];
          print('✅ Successfully loaded ${schedules.length} schedules');
          
          // Debug: print all schedules
          for (var i = 0; i < schedules.length; i++) {
            print('${i + 1}. ${schedules[i]['nama_matkul']} - ${schedules[i]['hari']} - ${schedules[i]['waktu']}');
          }
          
          return schedules;
        } else {
          throw Exception(data['message'] ?? 'Failed to load jadwal');
        }
      } else {
        throw Exception('HTTP ${response.statusCode} - Failed to load jadwal');
      }
    } catch (e) {
      print('❌ Error loading jadwal: $e');
      rethrow;
    }
  }

  Future<void> hapusJadwal(int jadwalId) async {
    try {
      print('🗑️ Deleting schedule: $jadwalId');
      final response = await http.delete(
        Uri.parse('$_baseUrl/jadwal/$jadwalId'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode != 200) {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to delete jadwal');
      }
      print('✅ Successfully deleted schedule: $jadwalId');
    } catch (e) {
      print('❌ Error deleting jadwal: $e');
      rethrow;
    }
  }

  Future<void> tambahJadwal(Map<String, dynamic> jadwalData) async {
    try {
      print('➕ Adding new schedule: $jadwalData');
      final response = await http.post(
        Uri.parse('$_baseUrl/jadwal'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(jadwalData),
      );

      print('📡 Add schedule response: ${response.statusCode}');
      print('📡 Add schedule body: ${response.body}');

      if (response.statusCode != 201) {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to add jadwal');
      }
      print('✅ Successfully added schedule');
    } catch (e) {
      print('❌ Error adding jadwal: $e');
      rethrow;
    }
  }

  Future<List<dynamic>> dapatkanJadwalHariIni(int userId) async {
    try {
      print('📅 Getting today\'s schedule for user: $userId');
      
      // Try using dedicated endpoint first
      try {
        final response = await http.get(
          Uri.parse('$_baseUrl/jadwal/hari-ini/$userId'),
          headers: {'Accept': 'application/json'},
        );

        print('📡 Today\'s schedule response status: ${response.statusCode}');
        print('📡 Today\'s schedule response body: ${response.body}');

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['status'] == 'success') {
            final todaySchedules = data['data'] ?? [];
            print('✅ Successfully loaded ${todaySchedules.length} schedules for today (from endpoint)');
            return _sortSchedulesByTime(todaySchedules);
          }
        }
      } catch (e) {
        print('⚠️ Endpoint /jadwal/hari-ini/$userId not available, falling back to manual filtering');
      }

      // Fallback: manual filtering from all schedules
      return await _filterJadwalHariIniManual(userId);
      
    } catch (e) {
      print('❌ Error loading today\'s schedule: $e');
      rethrow;
    }
  }

  Future<List<dynamic>> _filterJadwalHariIniManual(int userId) async {
    try {
      print('🔄 Using manual filtering for today\'s schedule');
      
      // Get all schedules
      final allSchedules = await dapatkanJadwal(userId);
      
      // Get current day name
      final now = DateTime.now();
      final currentDay = _hariMapping[now.weekday.toEnglishDayName()] ?? '';
      
      print('📅 Current day: $currentDay (weekday: ${now.weekday})');
      print('📋 All schedules: ${allSchedules.length}');
      
      // Debug: print all schedules
      for (int i = 0; i < allSchedules.length; i++) {
        final schedule = allSchedules[i];
        print('📝 Schedule $i: ${schedule['nama_matkul']} - ${schedule['hari']} - ${schedule['waktu']}');
      }
      
      // Filter schedules for today with string normalization
      final todaySchedules = allSchedules.where((schedule) {
        final scheduleDay = _normalizeString(schedule['hari']?.toString() ?? '');
        final normalizedCurrentDay = _normalizeString(currentDay);
        final isToday = scheduleDay == normalizedCurrentDay;
        print('🔍 Comparing "$scheduleDay" with "$normalizedCurrentDay" = $isToday');
        return isToday;
      }).toList();
      
      print('✅ Found ${todaySchedules.length} schedules for today (manual filter)');
      
      // Debug: print today's schedules
      for (int i = 0; i < todaySchedules.length; i++) {
        final schedule = todaySchedules[i];
        print('📅 Today\'s schedule $i: ${schedule['nama_matkul']} - ${schedule['waktu']}');
      }
      
      // Sort by time
      return _sortSchedulesByTime(todaySchedules);
    } catch (e) {
      print('❌ Error in manual filtering: $e');
      rethrow;
    }
  }

  String _normalizeString(String input) {
    return input.trim().toLowerCase();
  }

  List<dynamic> _sortSchedulesByTime(List<dynamic> schedules) {
    schedules.sort((a, b) {
      final timeA = _parseTime(a['waktu']?.toString() ?? '');
      final timeB = _parseTime(b['waktu']?.toString() ?? '');
      return timeA.compareTo(timeB);
    });
    return schedules;
  }

  int _parseTime(String timeString) {
    try {
      // Take first hour from format "HH:MM - HH:MM" or "HH:MM"
      final timePart = timeString.split(' - ')[0].trim();
      final parts = timePart.split(':');
      if (parts.length >= 2) {
        final hour = int.tryParse(parts[0]) ?? 0;
        final minute = int.tryParse(parts[1]) ?? 0;
        return hour * 60 + minute; // Convert to minutes for comparison
      }
    } catch (e) {
      print('⚠️ Error parsing time: $timeString - $e');
    }
    return 0;
  }

  Future<Map<String, List<dynamic>>> dapatkanJadwalHariIniByPeriod(int userId) async {
    try {
      final todaySchedules = await dapatkanJadwalHariIni(userId);
      
      final Map<String, List<dynamic>> schedulePeriods = {
        'Pagi': [],
        'Siang': [],
        'Malam': [],
      };

      for (final schedule in todaySchedules) {
        final period = _getTimePeriod(schedule['waktu']?.toString() ?? '');
        schedulePeriods[period]?.add(schedule);
      }

      print('📊 Schedule periods: Pagi(${schedulePeriods['Pagi']?.length}), Siang(${schedulePeriods['Siang']?.length}), Malam(${schedulePeriods['Malam']?.length})');
      
      return schedulePeriods;
    } catch (e) {
      print('❌ Error getting schedule by period: $e');
      rethrow;
    }
  }

  String _getTimePeriod(String timeString) {
    try {
      final timePart = timeString.split(' - ')[0].trim();
      final parts = timePart.split(':');
      if (parts.length >= 2) {
        final hour = int.tryParse(parts[0]) ?? 0;
        
        if (hour >= 6 && hour < 12) {
          return 'Pagi';
        } else if (hour >= 12 && hour < 18) {
          return 'Siang';
        } else {
          return 'Malam';
        }
      }
    } catch (e) {
      print('⚠️ Error determining time period: $timeString - $e');
    }
    return 'Siang'; // Default
  }

  Future<int> hitungJadwalHariIni(int userId) async {
    try {
      final todaySchedules = await dapatkanJadwalHariIni(userId);
      final count = todaySchedules.length;
      print('📊 Today\'s schedule count: $count');
      return count;
    } catch (e) {
      print('❌ Error counting today\'s schedule: $e');
      return 0;
    }
  }

  Future<int> hitungSKSHariIni(int userId) async {
    try {
      final todaySchedules = await dapatkanJadwalHariIni(userId);
      final totalSKS = todaySchedules.fold<int>(0, (sum, schedule) {
        final sks = int.tryParse(schedule['sks']?.toString() ?? '0') ?? 0;
        return sum + sks;
      });
      print('📊 Today\'s total SKS: $totalSKS');
      return totalSKS;
    } catch (e) {
      print('❌ Error counting today\'s SKS: $e');
      return 0;
    }
  }

  /// Fungsi yang diperbaiki untuk mengelompokkan jadwal per hari
  Map<String, List<dynamic>> groupJadwalByDay(List<dynamic> jadwalList, String searchQuery) {
    final jadwalPerHari = <String, List<dynamic>>{};
    
    // Initialize all days
    for (var indonesianDay in _hari) {
      jadwalPerHari[indonesianDay] = [];
    }
    
    print('🔍 Grouping ${jadwalList.length} schedules by day with search: "$searchQuery"');
    
    for (var schedule in jadwalList) {
      final scheduleDay = schedule['hari']?.toString() ?? '';
      print('📅 Processing schedule: ${schedule['nama_matkul']} - Day: "$scheduleDay"');
      
      // Convert day from database to Indonesian
      String? indonesianDay;
      
      // Check if it's already in Indonesian
      if (_hari.contains(scheduleDay)) {
        indonesianDay = scheduleDay;
      } else {
        // Convert from English to Indonesian
        indonesianDay = _hariMapping[scheduleDay];
      }
      
      if (indonesianDay != null) {
        // Apply search filter
        final query = searchQuery.toLowerCase();
        final matchesQuery = query.isEmpty ||
            (schedule['nama_matkul']?.toString() ?? '').toLowerCase().contains(query) ||
            (schedule['kode_matkul']?.toString() ?? '').toLowerCase().contains(query) ||
            (schedule['dosen']?.toString() ?? '').toLowerCase().contains(query) ||
            (schedule['kelas']?.toString() ?? '').toLowerCase().contains(query);
        
        if (matchesQuery) {
          jadwalPerHari[indonesianDay]!.add(schedule);
          print('✅ Added to $indonesianDay: ${schedule['nama_matkul']}');
        } else {
          print('❌ Filtered out by search: ${schedule['nama_matkul']}');
        }
      } else {
        print('⚠️ Unknown day format: "$scheduleDay"');
      }
    }
    
    // Sort schedules within each day by time
    for (var day in jadwalPerHari.keys) {
      jadwalPerHari[day] = _sortSchedulesByTime(jadwalPerHari[day]!);
      if (jadwalPerHari[day]!.isNotEmpty) {
        print('📅 $day has ${jadwalPerHari[day]!.length} schedules');
      }
    }
    
    return jadwalPerHari;
  }

  /// Helper method to get Indonesian day name from English
  String? getIndonesianDay(String englishDay) {
    return _hariMapping[englishDay];
  }

  /// Helper method to get English day name from Indonesian
  String? getEnglishDay(String indonesianDay) {
    return _hariMapping.entries
        .firstWhere(
          (entry) => entry.value == indonesianDay,
          orElse: () => const MapEntry('', ''),
        )
        .key;
  }
}

extension WeekdayExtension on int {
  String toEnglishDayName() {
    switch (this) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return '';
    }
  }
}