class PredictionModel {
  final String ingredientId;
  final String ingredientName;
  final double currentStock;
  final double dailyConsumption;
  final double minThreshold;
  final double predictedDaysUntilEmpty;
  final String predictionDate;
  final String recommendation;
  final double recommendedReorderQuantity;
  final String status;
  final String unit;
  final List<Map<String, dynamic>> consumptionHistory;

  PredictionModel({
    required this.ingredientId,
    required this.ingredientName,
    required this.currentStock,
    required this.dailyConsumption,
    required this.minThreshold,
    required this.predictedDaysUntilEmpty,
    required this.predictionDate,
    required this.recommendation,
    required this.recommendedReorderQuantity,
    required this.status,
    required this.unit,
    required this.consumptionHistory,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      ingredientId: json['ingredientId'] ?? '',
      ingredientName: json['ingredientName'] ?? '',
      currentStock: (json['currentStock'] ?? 0).toDouble(),
      dailyConsumption: (json['dailyConsumption'] ?? 0).toDouble(),
      minThreshold: (json['minThreshold'] ?? 0).toDouble(),
      predictedDaysUntilEmpty: (json['predictedDaysUntilEmpty'] ?? 0).toDouble(),
      predictionDate: json['predictionDate'] ?? '',
      recommendation: json['recommendation'] ?? '',
      recommendedReorderQuantity: (json['recommendedReorderQuantity'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      unit: json['unit'] ?? '',
      consumptionHistory: (json['consumptionHistory'] as List<dynamic>?)
              ?.map((e) => Map<String, dynamic>.from(e))
              .toList() ??
          [],
    );
  }
}