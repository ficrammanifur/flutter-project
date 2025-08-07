import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/prediction_service.dart';
import '../models/prediction_model.dart';

class PredictionsScreen extends StatefulWidget {
  const PredictionsScreen({super.key});

  @override
  _PredictionsScreenState createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends State<PredictionsScreen> {
  final PredictionService predictionService = PredictionService();
  Map<String, Map<String, dynamic>> arimaResults = {};
  List<PredictionModel> predictions = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchPredictions();
  }

  Future<void> _fetchPredictions() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final data = await predictionService.getStockPredictions();
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
      final result = await predictionService.calculateARIMAPrediction(ingredientId);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediksi Stok'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchPredictions,
            tooltip: 'Refresh Predictions',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text('Error: $errorMessage'))
              : predictions.isEmpty
                  ? const Center(child: Text('Tidak ada prediksi tersedia'))
                  : ListView.builder(
                      itemCount: predictions.length,
                      itemBuilder: (context, index) {
                        final prediction = predictions[index];
                        final arimaResult = arimaResults[prediction.ingredientId];
                        final hasEnoughData = prediction.consumptionHistory.length >= 7 &&
                            prediction.consumptionHistory.every((e) => e['consumption'] != null && e['date'].toString().isNotEmpty);
                        return ExpansionTile(
                          title: Text(prediction.ingredientName),
                          subtitle: Text(
                            'Hari hingga habis: ${prediction.predictedDaysUntilEmpty.toStringAsFixed(2)} hari',
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Stok Saat Ini: ${prediction.currentStock} ${prediction.unit}'),
                                  Text('Konsumsi Harian: ${prediction.dailyConsumption.toStringAsFixed(1)} ${prediction.unit}'),
                                  Text('Saran Reorder: ${prediction.recommendedReorderQuantity} ${prediction.unit}'),
                                  Text('Status: ${prediction.status}'),
                                  Text('Rekomendasi: ${prediction.recommendation}'),
                                  Text('Tanggal Prediksi: ${prediction.predictionDate}'),
                                  const SizedBox(height: 10),
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
                                  if (arimaResult != null) ...[
                                    const SizedBox(height: 10),
                                    Text(
                                      'Prediksi Stok ARIMA: ${(arimaResult['predictedStock'] as List<dynamic>?)?.join(', ') ?? 'Tidak tersedia'} ${prediction.unit}',
                                    ),
                                    _buildStockChart(
                                      (arimaResult['predictedStock'] as List<dynamic>?) ?? [],
                                      prediction.unit,
                                    ),
                                    Text(
                                      'Prediksi Konsumsi ARIMA: ${(arimaResult['predictedConsumption'] as List<dynamic>?)?.join(', ') ?? 'Tidak tersedia'} ${prediction.unit}',
                                    ),
                                    _buildConsumptionChart(
                                      (arimaResult['predictedConsumption'] as List<dynamic>?) ?? [],
                                      prediction.unit,
                                    ),
                                    Text('Arah Tren: ${arimaResult['trend_direction'] ?? 'Tidak tersedia'}'),
                                    Text('Akurasi (MSE): ${(arimaResult['accuracy_metrics']?['mse'] ?? 0).toStringAsFixed(2)}'),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
    );
  }
}