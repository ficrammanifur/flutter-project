class IngredientModel {
  final String id;
  final String name;
  final double currentStock;
  final String unit;
  final int estimatedDaysLeft;
  final String stockStatus;
  final double minThreshold;

  IngredientModel({
    required this.id,
    required this.name,
    required this.currentStock,
    required this.unit,
    required this.estimatedDaysLeft,
    required this.stockStatus,
    required this.minThreshold,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'],
      name: json['name'],
      currentStock: json['currentStock'].toDouble(),
      unit: json['unit'],
      estimatedDaysLeft: json['estimatedDaysLeft'],
      stockStatus: json['stockStatus'],
      minThreshold: json['minThreshold'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'currentStock': currentStock,
      'unit': unit,
      'estimatedDaysLeft': estimatedDaysLeft,
      'stockStatus': stockStatus,
      'minThreshold': minThreshold,
    };
  }
}
