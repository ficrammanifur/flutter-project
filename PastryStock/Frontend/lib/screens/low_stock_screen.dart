import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/ingredient_model.dart';

class LowStockScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  LowStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IngredientModel>>(
      future: apiService.getLowStockIngredients(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No low stock ingredients'));
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
            );
          },
        );
      },
    );
  }
}