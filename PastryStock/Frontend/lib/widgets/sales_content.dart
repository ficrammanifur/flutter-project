//sales_content.dart
import 'package:flutter/material.dart';
import '../models/sales_model.dart';
import '../services/api_service.dart';

class SalesContent extends StatefulWidget {
  const SalesContent({super.key});

  @override
  State<SalesContent> createState() => _SalesContentState();
}

class _SalesContentState extends State<SalesContent> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  
  String selectedMenu = 'Madaline';
  int quantity = 1;
  double price = 0;
  
  final List<String> menus = [
    'Madaline',
    'Muffin',
    'Mini Muffin',
    'Cheesecake',
    'Sable Cookies',
  ];

  final Map<String, double> menuPrices = {
    'Madaline': 45000,
    'Muffin': 35000,
    'Mini Muffin': 17000,
    'Cheesecake': 75000,
    'Sable Cookies': 35000,
  };

  List<SalesModel> todaySales = [];

  @override
  void initState() {
    super.initState();
    price = menuPrices[selectedMenu] ?? 0;
    _loadTodaySales();
  }

  _loadTodaySales() async {
    final sales = await _apiService.getTodaySales();
    setState(() {
      todaySales = sales;
    });
  }

  _addSale() async {
    if (_formKey.currentState!.validate()) {
      final sale = SalesModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        menuName: selectedMenu,
        quantity: quantity,
        pricePerItem: price,
        totalAmount: price * quantity,
        date: DateTime.now(),
      );

      await _apiService.addSale(sale);
      _loadTodaySales();
      
      // Reset form
      setState(() {
        quantity = 1;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Penjualan berhasil ditambahkan!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input Form
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Input Penjualan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Menu Dropdown
                    DropdownButtonFormField<String>(
                      value: selectedMenu,
                      decoration: const InputDecoration(
                        labelText: 'Pilih Menu',
                        border: OutlineInputBorder(),
                      ),
                      items: menus.map((menu) => DropdownMenuItem(
                        value: menu,
                        child: Text(menu),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedMenu = value!;
                          price = menuPrices[selectedMenu] ?? 0;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Quantity Input
                    TextFormField(
                      initialValue: quantity.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Jumlah',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jumlah tidak boleh kosong';
                        }
                        if (int.tryParse(value) == null || int.parse(value) <= 0) {
                          return 'Jumlah harus lebih dari 0';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          quantity = int.tryParse(value) ?? 1;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Price Display
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Harga:'),
                          Text(
                            'Rp ${(price * quantity).toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _addSale,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Tambah Penjualan'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Today's Sales
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Penjualan Hari Ini',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (todaySales.isEmpty)
                    const Center(
                      child: Text('Belum ada penjualan hari ini'),
                    )
                  else
                    ...todaySales.map((sale) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          sale.quantity.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(sale.menuName),
                      subtitle: Text('${sale.quantity} x Rp ${sale.pricePerItem.toStringAsFixed(0)}'),
                      trailing: Text(
                        'Rp ${sale.totalAmount.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
}
