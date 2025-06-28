import 'package:flutter/material.dart';
import '/services/jadwal_service.dart';
import 'input_jadwal_page.dart';

class LihatJadwalPage extends StatefulWidget {
  final int userId;
  final int? initialDay;

  const LihatJadwalPage({
    super.key,
    required this.userId,
    this.initialDay,
  });

  @override
  State<LihatJadwalPage> createState() => _LihatJadwalPageState();
}

class _LihatJadwalPageState extends State<LihatJadwalPage>
    with TickerProviderStateMixin {
  final JadwalService _jadwalService = JadwalService();
  final List<String> _hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
  final TextEditingController _searchController = TextEditingController();

  List<dynamic> _jadwalList = [];
  Map<String, List<dynamic>> _jadwalPerHari = {};
  bool _isLoading = true;
  String _searchQuery = '';
  int? _expandedDayIndex;
  String? _errorMessage;
  late AnimationController _animationController;
  bool _isEmptyState = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fetchJadwal();
    _animationController.forward();

    if (widget.initialDay != null) {
      _expandedDayIndex = (widget.initialDay! - 1).clamp(0, 6);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchJadwal() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _isEmptyState = false;
    });
    
    try {
      final data = await _jadwalService.dapatkanJadwal(widget.userId);
      
      setState(() {
        _jadwalList = data;
        _isEmptyState = data.isEmpty;
        _isLoading = false;
        _updateJadwalGrouping();
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal memuat jadwal: ${_parseErrorMessage(e)}';
        _isLoading = false;
      });
    }
  }

  void _updateJadwalGrouping() {
    _jadwalPerHari = _jadwalService.groupJadwalByDay(_jadwalList, _searchQuery);
  }

  String _parseErrorMessage(dynamic error) {
    if (error.toString().contains('Failed host lookup')) {
      return 'Gagal terhubung ke server. Periksa koneksi internet Anda.';
    } else if (error.toString().contains('timeout')) {
      return 'Waktu tunggu habis. Server tidak merespon.';
    } else if (error.toString().contains('404')) {
      return 'Endpoint tidak ditemukan.';
    } else if (error.toString().contains('500')) {
      return 'Server mengalami masalah.';
    } else {
      return error.toString();
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
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildJadwalCard(Map<String, dynamic> matkul, List<Color> gradientColors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                gradientColors.first.withValues(alpha: 0.1),
                gradientColors.last.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradientColors),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.book,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            matkul['nama_matkul'] ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            matkul['kode_matkul'] ?? 'Kode: N/A',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradientColors),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${matkul['sks'] ?? '0'} SKS',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: gradientColors.first,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          matkul['waktu'] ?? 'Waktu: N/A',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.class_,
                          size: 16,
                          color: gradientColors.first,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Kelas ${matkul['kelas'] ?? 'N/A'}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: gradientColors.first,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        matkul['dosen'] ?? 'Dosen: N/A',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJadwalHari(String hari, List<dynamic> matakuliah, int index) {
    final gradientColors = _getGradientColors(index);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ExpansionTile(
          initiallyExpanded: _expandedDayIndex == index,
          onExpansionChanged: (expanded) {
            if (expanded) {
              setState(() {
                _expandedDayIndex = index;
              });
            }
          },
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.calendar_today,
              color: Colors.white,
              size: 20,
            ),
          ),
          title: Text(
            hari,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            '${matakuliah.length} mata kuliah',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          children: matakuliah.isEmpty
              ? [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.event_available,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tidak ada jadwal',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              : [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: matakuliah.map<Widget>((matkul) {
                        return GestureDetector(
                          onLongPress: () => _showDeleteDialog(matkul['id']),
                          child: _buildJadwalCard(matkul, gradientColors),
                        );
                      }).toList(),
                    ),
                  ),
                ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.schedule,
              size: 64,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Belum Ada Jadwal',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Anda belum memiliki jadwal kuliah. Tambahkan jadwal pertama Anda dengan menekan tombol + di bawah',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => InputJadwalPage(
                    userId: widget.userId,
                    onJadwalDitambahkan: _fetchJadwal,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Tambah Jadwal',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getGradientColors(int index) {
    final gradients = [
      [const Color(0xFF3B82F6), const Color(0xFF06B6D4)], // Blue to Cyan
      [const Color(0xFF10B981), const Color(0xFF34D399)], // Green
      [const Color(0xFFA855F7), const Color(0xFFEC4899)], // Purple to Pink
      [const Color(0xFFF59E0B), const Color(0xFFEF4444)], // Orange to Red
      [const Color(0xFF6366F1), const Color(0xFF8B5CF6)], // Indigo to Purple
      [const Color(0xFFEC4899), const Color(0xFFF43F5E)], // Pink to Rose
      [const Color(0xFF14B8A6), const Color(0xFF0EA5E9)], // Teal to Blue
    ];
    return gradients[index % gradients.length];
  }

  Future<void> _showDeleteDialog(int jadwalId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Jadwal'),
          content: const Text('Apakah Anda yakin ingin menghapus jadwal ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await _jadwalService.hapusJadwal(jadwalId);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Jadwal berhasil dihapus'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  await _fetchJadwal();
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Gagal menghapus jadwal: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kuliah'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchJadwal,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Floating background elements
          _buildFloatingElement(
            top: 100,
            left: -50,
            size: 200,
            color: const Color(0xFF3B82F6),
          ),
          _buildFloatingElement(
            top: 300,
            left: MediaQuery.of(context).size.width - 100,
            size: 150,
            color: const Color(0xFF10B981),
          ),
          _buildFloatingElement(
            top: MediaQuery.of(context).size.height - 200,
            left: 50,
            size: 250,
            color: const Color(0xFFA855F7),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Search bar
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Cari mata kuliah...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                          _updateJadwalGrouping();
                        });
                      },
                    ),
                  ),

                  // Main content
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : _errorMessage != null
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.error_outline,
                                        size: 48,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        _errorMessage!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed: _fetchJadwal,
                                        child: const Text('Coba Lagi'),
                                      ),
                                    ],
                                  ),
                                )
                              : _isEmptyState
                                  ? _buildEmptyState()
                                  : ListView.builder(
                                      itemCount: _hari.length,
                                      itemBuilder: (context, index) {
                                        final hari = _hari[index];
                                        final jadwalHari = _jadwalPerHari[hari] ?? [];
                                        return _buildJadwalHari(hari, jadwalHari, index);
                                      },
                                    ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => InputJadwalPage(
                userId: widget.userId,
                onJadwalDitambahkan: _fetchJadwal,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}