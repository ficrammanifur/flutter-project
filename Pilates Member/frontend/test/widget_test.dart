import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PilatesApp());

    // Verify that the app starts properly
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
