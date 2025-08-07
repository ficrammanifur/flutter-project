import 'package:flutter/material.dart';
import '../models/ingredient_model.dart';
import '../widgets/prediction_content.dart';
import '../services/api_service.dart';

class InventoryContent extends StatefulWidget {
  const InventoryContent({super.key});

  @override
  State<InventoryContent> createState() => _InventoryContentState();
}

class _InventoryContentState extends State<InventoryContent> {
  final ApiService _apiService = ApiService();
  List<IngredientModel> ingredients = [];
  bool showPrediction = false;

  @override
  void initState() {
    super.initState();
    _loadIngredients();
  }

  _loadIngredients() async {
    final data = await _apiService.getAllIngredients();
    setState(() {
      ingredients = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toggle Button
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showPrediction = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !showPrediction 
                        ? Theme.of(context).primaryColor 
                        : Colors.grey.shade300,
                    foregroundColor: !showPrediction 
                        ? Colors.white 
                        : Colors.black,
                  ),
                  child: const Text('Stok Saat Ini'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showPrediction = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: showPrediction 
                        ? Theme.of(context).primaryColor 
                        : Colors.grey.shade300,
                    foregroundColor: showPrediction 
                        ? Colors.white 
                        : Colors.black,
                  ),
                  child: const Text('Prediksi ARIMA'),
                ),
              ),
            ],
          ),
        ),

        // Content
        Expanded(
          child: showPrediction 
              ? const PredictionContent()
              : _buildInventoryList(),
        ),
      ],
    );
  }

  Widget _buildInventoryList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = ingredients[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _getStockStatusColor(ingredient.stockStatus).withAlpha(51),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                Icons.inventory_2,
                color: _getStockStatusColor(ingredient.stockStatus),
              ),
            ),
            title: Text(
              ingredient.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stok: ${ingredient.currentStock} ${ingredient.unit}'),
                Text('Estimasi: ${ingredient.estimatedDaysLeft} hari lagi'),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStockStatusColor(ingredient.stockStatus),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                ingredient.stockStatus,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () => _showUpdateStockDialog(ingredient),
          ),
        );
      },
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

  _showUpdateStockDialog(IngredientModel ingredient) {
    final controller = TextEditingController(text: ingredient.currentStock.toString());
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Stok ${ingredient.name}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Jumlah Stok (${ingredient.unit})',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newStock = double.tryParse(controller.text) ?? 0;
              await _apiService.updateIngredientStock(ingredient.id, newStock);
              _loadIngredients();
              if (!context.mounted) return;
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Stok berhasil diupdate!')),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
