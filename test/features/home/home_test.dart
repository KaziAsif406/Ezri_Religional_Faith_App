import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template_flutter/features/home/presentation/home.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('HomeScreen', () {
    testWidgets('renders without errors', (WidgetTester tester) async {
      await tester.pumpWidget(simpleTestableWidget(const HomeScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('displays "Home" text', (WidgetTester tester) async {
      await tester.pumpWidget(simpleTestableWidget(const HomeScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('centers the "Home" text', (WidgetTester tester) async {
      await tester.pumpWidget(simpleTestableWidget(const HomeScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(Center), findsWidgets);
    });
  });
}
