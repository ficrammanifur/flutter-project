import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/ingredient_model.dart';

class IngredientsScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  IngredientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IngredientModel>>(
      future: apiService.getAllIngredients(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No ingredients found'));
        }

        final ingredients = snapshot.data!;
        return ListView.builder(
          itemCount: ingredients.length,
          itemBuilder: (context, index) {
            final ingredient = ingredients[index];
            return ListTile(
              title: Text(ingredient.name),
              subtitle: Text(
                'Stock: ${ingredient.currentStock} ${ingredient.unit} | Status: ${ingredient.stockStatus}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showUpdateStockDialog(context, ingredient);
                },
              ),
            );
          },
        );
      },
    );
  }

  void _showUpdateStockDialog(BuildContext context, IngredientModel ingredient) {
    final TextEditingController stockController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Stock for ${ingredient.name}'),
          content: TextField(
            controller: stockController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'New Stock'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final newStock = double.tryParse(stockController.text);
                if (newStock != null) {
                  await apiService.updateIngredientStock(ingredient.id, newStock);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Stock updated')),
                  );
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}