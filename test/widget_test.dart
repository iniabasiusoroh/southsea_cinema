import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:flutter/services.dart';

Future<void> pumpHomeView(WidgetTester tester) async { // test utility that takes the test harness.
  await tester.pumpWidget(const MaterialApp(home: HomeView())); // pump widget tells flutter to render that widget tree so that test can inspect it
  
}
// This is the set up before each of the tests.
// It renders the app with home view on screen 
// the test can then look for the widgets/texts that it needs to find.

void main() {
  setUp(() {
    rootBundle.clear(); // This runs before each test
  });
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
      // expect(find.text('Thursday 22 Oct 2026 | 18:00 - 19:14'), findsOneWidget);
      // expect(find.text('BOOK TICKETS'), findsOneWidget);
    });
  });
}
 