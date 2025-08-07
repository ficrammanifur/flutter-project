import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/prediction_model.dart';
import '../services/prediction_service.dart';
import '../services/auth_service.dart';

class PredictionContent extends StatefulWidget {
  const PredictionContent({super.key});

  @override
  State<PredictionContent> createState() => _PredictionContentState();
}

class _PredictionContentState extends State<PredictionContent> {
  final PredictionService _predictionService = PredictionService();
  final AuthService _authService = AuthService();
  List<PredictionModel> predictions = [];
  Map<String, Map<String, dynamic>> arimaResults = {};
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _checkAuthAndLoadPredictions();
  }

  Future<void> _checkAuthAndLoadPredictions() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    final isLoggedIn = await _authService.checkAuthStatus();
    if (!isLoggedIn) {
      setState(() {
        errorMessage = 'Silakan login untuk melihat prediksi';
        isLoading = false;
      });
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    await _loadPredictions();
  }

  Future<void> _loadPredictions() async {
    try {
      final data = await _predictionService.getStockPredictions();
      setState(() {
        predictions = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Gagal memuat prediksi: $e';
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat prediksi: $e')),
      );
    }
  }

  Future<void> _fetchARIMAPrediction(String ingredientId) async {
    try {
      final result = await _predictionService.calculateARIMAPrediction(ingredientId);
      setState(() {
        arimaResults[ingredientId] = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat prediksi ARIMA: $e')),
      );
    }
  }

  Widget _buildStockChart(List<dynamic> predictedStock, String unit) {
    if (predictedStock.isEmpty || predictedStock.any((e) => e == null)) {
      return const Text('Data stok prediksi tidak tersedia');
    }
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => Text(
                  '${value.toInt()} $unit',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text(
                  'Hari ${value.toInt() + 1}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: predictedStock
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                  .toList(),
              isCurved: true,
              color: Colors.blue,
              barWidth: 2,
              dotData: FlDotData(show: true),
            ),
          ],
          minY: 0,
          maxY: predictedStock.isNotEmpty
              ? (predictedStock.reduce((a, b) => a > b ? a : b) * 1.2).toDouble()
              : 100,
        ),
      ),
    );
  }

  Widget _buildConsumptionChart(List<dynamic> predictedConsumption, String unit) {
    if (predictedConsumption.isEmpty || predictedConsumption.any((e) => e == null)) {
      return const Text('Data konsumsi prediksi tidak tersedia');
    }
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => Text(
                  '${value.toInt()} $unit',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text(
                  'Hari ${value.toInt() + 1}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: predictedConsumption
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                  .toList(),
              isCurved: true,
              color: Colors.red,
              barWidth: 2,
              dotData: FlDotData(show: true),
            ),
          ],
          minY: 0,
          maxY: predictedConsumption.isNotEmpty
              ? (predictedConsumption.reduce((a, b) => a > b ? a : b) * 1.2).toDouble()
              : 100,
        ),
      ),
    );
  }

  Widget _buildConsumptionHistoryChart(List<dynamic> consumptionHistory, String unit) {
    final validHistory = consumptionHistory
        .asMap()
        .entries
        .where((e) => e.value['consumption'] != null && e.value['date'].toString().isNotEmpty)
        .map((e) => {'index': e.key, 'consumption': e.value['consumption']})
        .toList();
    if (validHistory.isEmpty) {
      return const Text('Data riwayat konsumsi tidak tersedia');
    }
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => Text(
                  '${value.toInt()} $unit',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text(
                  'Hari ${value.toInt() + 1}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: validHistory
                  .map((e) => FlSpot(
                        e['index'].toDouble(),
                        e['consumption'].toDouble(),
                      ))
                  .toList(),
              isCurved: true,
              color: Colors.green,
              barWidth: 2,
              dotData: FlDotData(show: true),
            ),
          ],
          minY: 0,
          maxY: validHistory.isNotEmpty
              ? (validHistory.map((e) => e['consumption']).reduce((a, b) => a > b ? a : b) * 1.2).toDouble()
              : 100,
        ),
      ),
    );
  }

  Color _getPredictionStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'aman':
      case 'sufficient':
        return Colors.green;
      case 'perlu perhatian':
      case 'low stock':
        return Colors.orange;
      case 'segera pesan':
      case 'critical':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildPredictionItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        body: Center(child: Text('Error: $errorMessage')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediksi Stok'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _checkAuthAndLoadPredictions,
            tooltip: 'Refresh Predictions',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.analytics, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Prediksi ARIMA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Prediksi kebutuhan stok berdasarkan pola penjualan historis menggunakan model ARIMA',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...predictions.map((prediction) {
              final hasEnoughData = prediction.consumptionHistory.length >= 7 &&
                  prediction.consumptionHistory.every((e) => e['consumption'] != null && e['date'].toString().isNotEmpty);
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            prediction.ingredientName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getPredictionStatusColor(prediction.status),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              prediction.status,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildPredictionItem(
                              'Stok Saat Ini',
                              '${prediction.currentStock} ${prediction.unit}',
                              Icons.inventory,
                            ),
                          ),
                          Expanded(
                            child: _buildPredictionItem(
                              'Prediksi Habis',
                              '${prediction.predictedDaysUntilEmpty.toStringAsFixed(2)} hari',
                              Icons.schedule,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildPredictionItem(
                              'Konsumsi Harian',
                              '${prediction.dailyConsumption.toStringAsFixed(1)} ${prediction.unit}',
                              Icons.trending_down,
                            ),
                          ),
                          Expanded(
                            child: _buildPredictionItem(
                              'Saran Reorder',
                              '${prediction.recommendedReorderQuantity} ${prediction.unit}',
                              Icons.add_shopping_cart,
                            ),
                          ),
                        ],
                      ),
                      if (prediction.recommendation.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lightbulb,
                                color: Colors.amber.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  prediction.recommendation,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (prediction.consumptionHistory.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text('Riwayat Konsumsi (${prediction.unit}):'),
                        _buildConsumptionHistoryChart(prediction.consumptionHistory, prediction.unit),
                      ],
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: hasEnoughData
                            ? () => _fetchARIMAPrediction(prediction.ingredientId)
                            : null,
                        child: Text(
                          hasEnoughData
                              ? 'Lihat Prediksi ARIMA'
                              : 'Data Tidak Cukup untuk ARIMA',
                        ),
                      ),
                      if (arimaResults.containsKey(prediction.ingredientId)) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Prediksi Stok (${prediction.unit}):',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        _buildStockChart(
                          (arimaResults[prediction.ingredientId]!['predictedStock'] as List<dynamic>?) ?? [],
                          prediction.unit,
                        ),
                        Text(
                          'Prediksi Konsumsi (${prediction.unit}):',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        _buildConsumptionChart(
                          (arimaResults[prediction.ingredientId]!['predictedConsumption'] as List<dynamic>?) ?? [],
                          prediction.unit,
                        ),
                        Text(
                          'Arah Tren: ${arimaResults[prediction.ingredientId]!['trend_direction'] ?? 'Tidak tersedia'}',
                        ),
                        Text(
                          'Akurasi (MSE): ${(arimaResults[prediction.ingredientId]!['accuracy_metrics']?['mse'] ?? 0).toStringAsFixed(2)}',
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tentang Prediksi ARIMA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Model ARIMA menganalisis pola penjualan historis\n'
                      '• Memprediksi kebutuhan stok berdasarkan tren dan musiman\n'
                      '• Memberikan rekomendasi waktu dan jumlah pemesanan\n'
                      '• Akurasi meningkat dengan data historis yang lebih banyak',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _checkAuthAndLoadPredictions,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Refresh Prediksi'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
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