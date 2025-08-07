import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sales_model.dart';
import '../models/ingredient_model.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000/api';
  
  // Demo mode - using local dummy data
  bool isDemoMode = true;

  // Dummy data for demo mode
  final List<SalesModel> _dummySales = [
    SalesModel(
      id: '1',
      menuName: 'Madaline',
      quantity: 12,
      pricePerItem: 45000,
      totalAmount: 540000,
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    SalesModel(
      id: '2',
      menuName: 'Cheesecake',
      quantity: 8,
      pricePerItem: 75000,
      totalAmount: 600000,
      date: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    SalesModel(
      id: '3',
      menuName: 'Muffin',
      quantity: 15,
      pricePerItem: 35000,
      totalAmount: 525000,
      date: DateTime.now().subtract(const Duration(hours: 6)),
    ),
  ];

  final List<IngredientModel> _dummyIngredients = [
    IngredientModel(
      id: '1',
      name: 'Keju',
      currentStock: 500,
      unit: 'gram',
      estimatedDaysLeft: 3,
      stockStatus: 'Kritis',
      minThreshold: 200,
    ),
    IngredientModel(
      id: '2',
      name: 'Susu UHT Greenfields',
      currentStock: 2.5,
      unit: 'liter',
      estimatedDaysLeft: 7,
      stockStatus: 'Peringatan',
      minThreshold: 1.0,
    ),
    IngredientModel(
      id: '3',
      name: 'Dark Cokelat',
      currentStock: 1200,
      unit: 'gram',
      estimatedDaysLeft: 12,
      stockStatus: 'Aman',
      minThreshold: 300,
    ),
    IngredientModel(
      id: '4',
      name: 'Gula',
      currentStock: 800,
      unit: 'gram',
      estimatedDaysLeft: 5,
      stockStatus: 'Peringatan',
      minThreshold: 500,
    ),
    IngredientModel(
      id: '5',
      name: 'Matcha Bubuk',
      currentStock: 150,
      unit: 'gram',
      estimatedDaysLeft: 2,
      stockStatus: 'Kritis',
      minThreshold: 100,
    ),
  ];

  Future<List<SalesModel>> getRecentSales() async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 500));
      return _dummySales;
    }
    
    try {
      final response = await http.get(Uri.parse('$baseUrl/sales/recent'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => SalesModel.fromJson(item)).toList();
      }
      throw Exception('Failed to load sales data');
    } catch (e) {
      // Fallback to demo data if API fails
      return _dummySales;
    }
  }

  Future<List<SalesModel>> getTodaySales() async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 300));
      final today = DateTime.now();
      return _dummySales.where((sale) => 
        sale.date.day == today.day &&
        sale.date.month == today.month &&
        sale.date.year == today.year
      ).toList();
    }
    
    try {
      final response = await http.get(Uri.parse('$baseUrl/sales/today'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => SalesModel.fromJson(item)).toList();
      }
      throw Exception('Failed to load today sales');
    } catch (e) {
      return [];
    }
  }

  Future<void> addSale(SalesModel sale) async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 300));
      _dummySales.insert(0, sale);
      return;
    }
    
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sales'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(sale.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to add sale');
      }
    } catch (e) {
      throw Exception('Failed to add sale: $e');
    }
  }

  Future<List<IngredientModel>> getAllIngredients() async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 500));
      return _dummyIngredients;
    }
    
    try {
      final response = await http.get(Uri.parse('$baseUrl/ingredients'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => IngredientModel.fromJson(item)).toList();
      }
      throw Exception('Failed to load ingredients');
    } catch (e) {
      return _dummyIngredients;
    }
  }

  Future<List<IngredientModel>> getLowStockIngredients() async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 300));
      return _dummyIngredients.where((ingredient) => 
        ingredient.stockStatus == 'Kritis' || ingredient.stockStatus == 'Peringatan'
      ).toList();
    }
    
    try {
      final response = await http.get(Uri.parse('$baseUrl/ingredients/low-stock'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => IngredientModel.fromJson(item)).toList();
      }
      throw Exception('Failed to load low stock ingredients');
    } catch (e) {
      return [];
    }
  }

  Future<void> updateIngredientStock(String ingredientId, double newStock) async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 300));
      final index = _dummyIngredients.indexWhere((ingredient) => ingredient.id == ingredientId);
      if (index != -1) {
        final ingredient = _dummyIngredients[index];
        final updatedIngredient = IngredientModel(
          id: ingredient.id,
          name: ingredient.name,
          currentStock: newStock,
          unit: ingredient.unit,
          estimatedDaysLeft: (newStock / 50).round(), // Simple calculation
          stockStatus: newStock < ingredient.minThreshold ? 'Kritis' : 
                      newStock < ingredient.minThreshold * 2 ? 'Peringatan' : 'Aman',
          minThreshold: ingredient.minThreshold,
        );
        _dummyIngredients[index] = updatedIngredient;
      }
      return;
    }
    
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/ingredients/$ingredientId/stock'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'currentStock': newStock}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update stock');
      }
    } catch (e) {
      throw Exception('Failed to update stock: $e');
    }
  }

  Future<void> resetDemoData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Reset to original dummy data
    _dummySales.clear();
    _dummySales.addAll([
      SalesModel(
        id: '1',
        menuName: 'Madaline',
        quantity: 12,
        pricePerItem: 45000,
        totalAmount: 540000,
        date: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      SalesModel(
        id: '2',
        menuName: 'Cheesecake',
        quantity: 8,
        pricePerItem: 75000,
        totalAmount: 600000,
        date: DateTime.now().subtract(const Duration(hours: 4)),
      ),
    ]);
  }
}
