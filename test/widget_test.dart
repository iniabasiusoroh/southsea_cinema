import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/home_view.dart';

Future<void> pumpHomeView(WidgetTester tester) async { // test utility that takes the test harness.
  await tester.pumpWidget(const MaterialApp(home: HomeView())); // pump widget tells flutter to render that widget tree so that test can inspect it
  
}
// This is the set up big before each of the tests.
// It renders the app with home view on screen 
// the test can then lok for the widgets/texts that it needs to find.

void main() {
  group('App smoke tests', () {
    testWidgets('App displays HomeView as home', (WidgetTester tester) async {
      await pumpHomeView(tester);
      expect(find.byType(HomeView), findsOneWidget);
      expect(find.text('Southsea Cinema'), findsOneWidget);
    });

    testWidgets('Displays film cards with names, prices, and showtimes',
        (WidgetTester tester) async {
      await pumpHomeView(tester);
      expect(find.text('Southsea Cinema'), findsOneWidget);
      // expect(find.text('7.50'), findsOneWidget);
      expect(find.text('Thursday 22 Oct 2026'), findsOneWidget);
      expect(find.text('19:00'), findsOneWidget);
    });
  });
}
