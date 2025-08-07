import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../theme/app_theme.dart';
import '../../screens/auth/login_screen.dart';

class SettingsContent extends StatefulWidget {
  const SettingsContent({super.key});

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: AppTheme.primaryColor,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user?['name'] ?? 'User',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user?['email'] ?? 'user@example.com',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pengaturan Akun',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Ubah Profil'),
                    onTap: () {
                      // Navigate to profile edit screen
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text('Ubah Password'),
                    onTap: () {
                      // Navigate to change password screen
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informasi Aplikasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Versi Aplikasi'),
                    subtitle: Text('1.0.0'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.business),
                    title: Text('Target Pengguna'),
                    subtitle: Text('UMKM Bakery/Pastry Skala Kecil-Menengah'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.analytics),
                    title: const Text('Model Prediksi'),
                    subtitle: const Text('ARIMA (AutoRegressive Integrated Moving Average)'),
                    onTap: () => _showARIMAInfo(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Konfigurasi Backend',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ListTile(
                    leading: Icon(Icons.dns),
                    title: Text('Server URL'),
                    subtitle: Text('http://10.0.2.2:5000'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.wifi),
                    title: const Text('Test Koneksi'),
                    subtitle: const Text('Cek koneksi ke backend server'),
                    onTap: () => _testConnection(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Keluar',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () async {
                final shouldLogout = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Konfirmasi'),
                    content: const Text('Apakah Anda yakin ingin keluar?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Keluar'),
                      ),
                    ],
                  ),
                );

                if (shouldLogout == true && context.mounted) {
                  await _authService.logout();
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showARIMAInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Model ARIMA'),
        content: const SingleChildScrollView(
          child: Text(
            'ARIMA (AutoRegressive Integrated Moving Average) adalah model statistik yang digunakan untuk prediksi time series.\n\n'
            'Komponen ARIMA:\n'
            '• AR (AutoRegressive): Menggunakan nilai masa lalu untuk prediksi\n'
            '• I (Integrated): Mengatasi data yang tidak stasioner\n'
            '• MA (Moving Average): Menggunakan error masa lalu\n\n'
            'Dalam aplikasi ini, ARIMA digunakan untuk:\n'
            '• Memprediksi kebutuhan stok bahan baku\n'
            '• Menentukan waktu optimal untuk reorder\n'
            '• Mengoptimalkan inventory management',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Future<void> _testConnection() async {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Menguji koneksi ke server...')),
    );

    try {
      bool success = await _authService.testConnection();
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success 
                ? 'Koneksi ke server berhasil!' 
                : 'Gagal terhubung ke server',
          ),
          backgroundColor: success ? AppTheme.successColor : Colors.red,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}