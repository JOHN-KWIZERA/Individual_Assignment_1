import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temp_converter/main.dart';

void main() {
  testWidgets('Temperature Converter UI loads and functions', (WidgetTester tester) async {
    // Build the Temperature Converter App
    await tester.pumpWidget(const MyApp());

    // Check if toggle buttons are present
    expect(find.byType(ToggleButtons), findsOneWidget);

    // Check if text field is present
    expect(find.byType(TextField), findsOneWidget);

    // Check if Convert button is present
    expect(find.widgetWithText(ElevatedButton, 'Convert'), findsOneWidget);

    // Enter a temperature value into the input field
    await tester.enterText(find.byType(TextField), '100');

    // Tap the Convert button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Convert'));
    await tester.pump();

    // Expect a converted value to be shown in history
    expect(find.textContaining('=>'), findsOneWidget); // something like: "C to F: 100.0 => 212.0"
  });
}
