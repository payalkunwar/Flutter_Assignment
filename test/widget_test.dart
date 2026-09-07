import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:assignment4/main.dart';

void main() {
  testWidgets('Dashboard loads successfully', (WidgetTester tester) async {
    // Build the dashboard app.
    await tester.pumpWidget(const DashboardApp());

    // Verify that the main dashboard content is displayed.
    expect(find.text('Business Overview'), findsOneWidget);
    expect(find.text('Good evening, payal👋'), findsOneWidget);
    expect(find.text('Performance'), findsOneWidget);
    expect(find.text('Workspace'), findsOneWidget);
    expect(find.text('Recent Activity'), findsOneWidget);
  });

  testWidgets('Dashboard displays statistics', (WidgetTester tester) async {
    await tester.pumpWidget(const DashboardApp());

    // Verify statistic cards.
    expect(find.text('Total Revenue'), findsOneWidget);
    expect(find.text('\$24.5K'), findsOneWidget);

    expect(find.text('Total Orders'), findsOneWidget);
    expect(find.text('1,204'), findsOneWidget);

    expect(find.text('Customers'), findsOneWidget);
    expect(find.text('3,842'), findsOneWidget);

    expect(find.text('Pending'), findsOneWidget);
    expect(find.text('18'), findsOneWidget);
  });

  testWidgets('Dashboard displays projects', (WidgetTester tester) async {
    await tester.pumpWidget(const DashboardApp());

    // Verify project names.
    expect(find.text('Website Revamp'), findsOneWidget);
    expect(find.text('Mobile App V2'), findsOneWidget);
    expect(find.text('Marketing Q3'), findsOneWidget);
    expect(find.text('API Migration'), findsOneWidget);
    expect(find.text('User Research'), findsOneWidget);
    expect(find.text('Support Portal'), findsOneWidget);
  });

  testWidgets('Dashboard displays sidebar navigation on wide screen',
      (WidgetTester tester) async {
    // Use a desktop-sized screen so the sidebar is visible.
    await tester.binding.setSurfaceSize(
      const Size(1200, 800),
    );

    await tester.pumpWidget(const DashboardApp());

    expect(find.text('NEXORA'), findsOneWidget);
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Analytics'), findsOneWidget);
    expect(find.text('Orders'), findsOneWidget);
    expect(find.text('Customers'), findsOneWidget);
    expect(find.text('Inventory'), findsOneWidget);
    expect(find.text('Reports'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Reset the test screen size.
    await tester.binding.setSurfaceSize(null);
  });
}