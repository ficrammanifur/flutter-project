import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/sales_model.dart';
import 'package:intl/intl.dart';

class RecentSalesScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  RecentSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SalesModel>>(
      future: apiService.getRecentSales(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No recent sales'));
        }

        final sales = snapshot.data!;
        return ListView.builder(
          itemCount: sales.length,
          itemBuilder: (context, index) {
            final sale = sales[index];
            return ListTile(
              title: Text(sale.menuName),
              subtitle: Text(
                'Qty: ${sale.quantity} | Total: Rp ${sale.totalAmount} | ${DateFormat('dd MMM yyyy').format(sale.date)}',
              ),
            );
          },
        );
      },
    );
  }
}