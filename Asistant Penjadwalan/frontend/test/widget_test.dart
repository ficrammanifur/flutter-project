import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';
import 'package:frontend/pages/splash_screen.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Jalankan aplikasi
    await tester.pumpWidget(const MyApp());

    // Tunggu animasi/splash selesai (jika pakai Future.delayed atau semacamnya)
    await tester.pumpAndSettle();

    // Cek apakah SplashScreen atau teks yang sesuai muncul
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
