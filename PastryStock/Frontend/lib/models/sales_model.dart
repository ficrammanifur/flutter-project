class SalesModel {
  final String id;
  final String menuName;
  final int quantity;
  final double pricePerItem;
  final double totalAmount;
  final DateTime date;

  SalesModel({
    required this.id,
    required this.menuName,
    required this.quantity,
    required this.pricePerItem,
    required this.totalAmount,
    required this.date,
  });

  factory SalesModel.fromJson(Map<String, dynamic> json) {
    return SalesModel(
      id: json['id'],
      menuName: json['menuName'],
      quantity: json['quantity'],
      pricePerItem: json['pricePerItem'].toDouble(),
      totalAmount: json['totalAmount'].toDouble(),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'menuName': menuName,
      'quantity': quantity,
      'pricePerItem': pricePerItem,
      'totalAmount': totalAmount,
      'date': date.toIso8601String(),
    };
  }
}
