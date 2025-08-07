import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PastryStockApp());
}

class PastryStockApp extends StatelessWidget {
  const PastryStockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PastryStock',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
