import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';
import '../widgets/chart_card.dart';
import '../models/sales_model.dart';
import '../models/ingredient_model.dart';
import '../services/api_service.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  final ApiService _apiService = ApiService();
  List<SalesModel> recentSales = [];
  List<IngredientModel> lowStockIngredients = [];

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  _loadDashboardData() async {
    final sales = await _apiService.getRecentSales();
    final ingredients = await _apiService.getLowStockIngredients();
    
    setState(() {
      recentSales = sales;
      lowStockIngredients = ingredients;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Cards Row
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Penjualan Hari Ini',
                  value: '45',
                  subtitle: 'item terjual',
                  icon: Icons.trending_up,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  title: 'Stok Menipis',
                  value: '3',
                  subtitle: 'bahan baku',
                  icon: Icons.warning,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Sales Chart
          const ChartCard(),
          const SizedBox(height: 20),

          // Top Selling Items
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Menu Terlaris',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...recentSales.take(5).map((sale) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        sale.quantity.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(sale.menuName),
                    subtitle: Text('Terjual ${sale.quantity} hari ini'),
                    trailing: Text(
                      'Rp ${sale.totalAmount.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Low Stock Alert
          if (lowStockIngredients.isNotEmpty)
            Card(
              color: Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Peringatan Stok',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...lowStockIngredients.map((ingredient) => ListTile(
                      leading: Icon(
                        Icons.inventory_2,
                        color: _getStockStatusColor(ingredient.stockStatus),
                      ),
                      title: Text(ingredient.name),
                      subtitle: Text('Sisa: ${ingredient.currentStock} ${ingredient.unit}'),
                      trailing: Text(
                        '${ingredient.estimatedDaysLeft} hari',
                        style: TextStyle(
                          color: _getStockStatusColor(ingredient.stockStatus),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getStockStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'aman':
        return Colors.green;
      case 'peringatan':
        return Colors.orange;
      case 'kritis':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
