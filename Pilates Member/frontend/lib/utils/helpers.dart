import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:frontend/services/data_service.dart';

class Helpers {
  static bool _localeInitialized = false;

  static Future<void> _initializeLocale() async {
    if (!_localeInitialized) {
      try {
        await initializeDateFormatting('id_ID', null);
        _localeInitialized = true;
      } catch (e) {
        // Fallback to default locale if Indonesian locale fails
        _localeInitialized = true;
      }
    }
  }

  static String formatDate(DateTime date) {
    try {
      if (_localeInitialized) {
        return DateFormat('dd MMM yyyy', 'id_ID').format(date);
      } else {
        // Fallback to simple format without locale
        return DateFormat('dd MMM yyyy').format(date);
      }
    } catch (e) {
      // Ultimate fallback
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  static String formatDateTime(DateTime dateTime) {
    try {
      if (_localeInitialized) {
        return DateFormat('dd MMM yyyy - HH:mm', 'id_ID').format(dateTime);
      } else {
        return DateFormat('dd MMM yyyy - HH:mm').format(dateTime);
      }
    } catch (e) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  static String formatTime(DateTime time) {
    try {
      return DateFormat('HH:mm').format(time);
    } catch (e) {
      return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    }
  }

  // Updated to format Indonesian Rupiah
  static String formatCurrency(double amount) {
    try {
      final formatter = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      );
      return formatter.format(amount);
    } catch (e) {
      return formatIDR(amount);
    }
  }

  // Alternative simple IDR formatting
  static String formatIDR(double amount) {
    try {
      final formatter = NumberFormat('#,###', 'id_ID');
      return 'Rp ${formatter.format(amount)}';
    } catch (e) {
      // Simple fallback formatting
      final amountStr = amount.toStringAsFixed(0);
      final reversed = amountStr.split('').reversed.join('');
      final withDots = reversed.replaceAllMapped(
        RegExp(r'.{3}'),
        (match) => '${match.group(0)}.',
      );
      final formatted = withDots.split('').reversed.join('');
      return 'Rp ${formatted.endsWith('.') ? formatted.substring(0, formatted.length - 1) : formatted}';
    }
  }

  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Memuat...'),
            ],
          ),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static Future<void> launchWhatsAppPayment({
    required BuildContext context,
    required String packageName,
    required double amount,
    required String userName,
  }) async {
    try {
      await DataService.generateWhatsAppPaymentLink(
        packageName: packageName,
        amount: amount,
        userName: userName,
      );
      
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Instruksi Pembayaran'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Untuk menyelesaikan pembayaran:'),
                  const SizedBox(height: 10),
                  const Text('1. Klik "Buka WhatsApp" di bawah'),
                  const Text('2. Kirim pesan yang sudah disiapkan'),
                  const Text('3. Tunggu konfirmasi dari tim kami'),
                  const Text('4. Membership akan diaktifkan setelah pembayaran dikonfirmasi'),
                  const SizedBox(height: 20),
                  Text('Paket: $packageName'),
                  Text('Harga: ${formatIDR(amount)}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    // In a real app, you would use url_launcher to open WhatsApp
                    if (context.mounted) {
                      showSnackBar(context, 'Link pembayaran WhatsApp berhasil dibuat! (Mode Demo)');
                    }
                  },
                  child: const Text('Buka WhatsApp'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Gagal membuat link pembayaran', isError: true);
      }
    }
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'dikonfirmasi':
        return Colors.green;
      case 'pending':
      case 'menunggu':
        return Colors.orange;
      case 'cancelled':
      case 'dibatalkan':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'dikonfirmasi':
        return Icons.check_circle;
      case 'pending':
      case 'menunggu':
        return Icons.schedule;
      case 'cancelled':
      case 'dibatalkan':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  // Helper to get Indonesian status text
  static String getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return 'Dikonfirmasi';
      case 'pending':
        return 'Menunggu';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return status;
    }
  }

  // Initialize locale when app starts
  static Future<void> initialize() async {
    await _initializeLocale();
  }
}
