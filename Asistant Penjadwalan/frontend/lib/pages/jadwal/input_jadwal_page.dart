// lib/pages/input_jadwal_page.dart
import 'package:flutter/material.dart';
import '/services/jadwal_service.dart';

class InputJadwalPage extends StatefulWidget {
  final int userId;
  final Function()? onJadwalDitambahkan;

  const InputJadwalPage({
    super.key,
    required this.userId,
    this.onJadwalDitambahkan,
  });

  @override
  State<InputJadwalPage> createState() => _InputJadwalPageState();
}

class _InputJadwalPageState extends State<InputJadwalPage>
    with TickerProviderStateMixin {
  final JadwalService _jadwalService = JadwalService();
  final _formKey = GlobalKey<FormState>();
  final List<String> _days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];

  // Form controllers
  final _hariController = TextEditingController();
  final _waktuController = TextEditingController();
  final _kodeMatkulController = TextEditingController();
  final _namaMatkulController = TextEditingController();
  final _sksController = TextEditingController(text: '2');
  final _kelasController = TextEditingController();
  final _dosenController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _hariController.dispose();
    _waktuController.dispose();
    _kodeMatkulController.dispose();
    _namaMatkulController.dispose();
    _sksController.dispose();
    _kelasController.dispose();
    _dosenController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      try {
        final jadwalData = {
          'user_id': widget.userId,
          'hari': _hariController.text,
          'waktu': _waktuController.text,
          'kode_matkul': _kodeMatkulController.text,
          'nama_matkul': _namaMatkulController.text,
          'sks': int.parse(_sksController.text),
          'kelas': _kelasController.text,
          'dosen': _dosenController.text,
        };

        await _jadwalService.tambahJadwal(jadwalData);

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Jadwal berhasil ditambahkan'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );

        if (widget.onJadwalDitambahkan != null) {
          widget.onJadwalDitambahkan!();
        }

        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text('Gagal menambahkan jadwal: ${e.toString()}')),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildFloatingElement({
    required double top,
    required double left,
    required double size,
    required Color color,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? suffixIcon,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            readOnly: readOnly,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF10B981),
              Color(0xFF34D399),
              Color(0xFF6EE7B7),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Floating elements
            _buildFloatingElement(
              top: 100,
              left: 50,
              size: 80,
              color: Colors.white,
            ),
            _buildFloatingElement(
              top: 200,
              left: MediaQuery.of(context).size.width - 100,
              size: 60,
              color: Colors.yellow,
            ),
            _buildFloatingElement(
              top: 400,
              left: 80,
              size: 70,
              color: Colors.blue,
            ),

            // Main content
            SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Input Jadwal',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.add_circle,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Form content
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Day dropdown
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Hari',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      DropdownButtonFormField<String>(
                                        value: _hariController.text.isEmpty ? null : _hariController.text,
                                        decoration: InputDecoration(
                                          prefixIcon: Container(
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [Color(0xFF10B981), Color(0xFF34D399)],
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Icon(Icons.calendar_today, color: Colors.white, size: 20),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: const BorderSide(color: Color(0xFF10B981), width: 2),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 16,
                                          ),
                                        ),
                                        items: _days.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _hariController.text = value!;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Pilih hari';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                                _buildFormField(
                                  label: 'Waktu',
                                  controller: _waktuController,
                                  icon: Icons.access_time,
                                  hint: 'Contoh: 08:00-10:00',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Masukkan waktu';
                                    }
                                    return null;
                                  },
                                ),

                                _buildFormField(
                                  label: 'Kode Mata Kuliah',
                                  controller: _kodeMatkulController,
                                  icon: Icons.code,
                                  hint: 'Contoh: CS101',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Masukkan kode mata kuliah';
                                    }
                                    return null;
                                  },
                                ),

                                _buildFormField(
                                  label: 'Nama Mata Kuliah',
                                  controller: _namaMatkulController,
                                  icon: Icons.book,
                                  hint: 'Contoh: Pemrograman Web',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Masukkan nama mata kuliah';
                                    }
                                    return null;
                                  },
                                ),

                                _buildFormField(
                                  label: 'SKS',
                                  controller: _sksController,
                                  icon: Icons.star,
                                  hint: 'Jumlah SKS (1-6)',
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Masukkan SKS';
                                    }
                                    final sks = int.tryParse(value);
                                    if (sks == null || sks < 1 || sks > 6) {
                                      return 'SKS harus antara 1-6';
                                    }
                                    return null;
                                  },
                                ),

                                _buildFormField(
                                  label: 'Kelas',
                                  controller: _kelasController,
                                  icon: Icons.class_,
                                  hint: 'Contoh: A, B, C',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Masukkan kelas';
                                    }
                                    return null;
                                  },
                                ),

                                _buildFormField(
                                  label: 'Dosen',
                                  controller: _dosenController,
                                  icon: Icons.person,
                                  hint: 'Nama dosen pengampu',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Masukkan nama dosen';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 20),

                                // Submit button
                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _submitForm,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: _isLoading 
                                            ? null 
                                            : const LinearGradient(
                                                colors: [Color(0xFF10B981), Color(0xFF34D399)],
                                              ),
                                        color: _isLoading ? Colors.grey.withOpacity(0.3) : null,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: _isLoading
                                            ? const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                    ),
                                                  ),
                                                  SizedBox(width: 12),
                                                  Text(
                                                    'Menyimpan...',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.save, color: Colors.white),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Simpan Jadwal',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}