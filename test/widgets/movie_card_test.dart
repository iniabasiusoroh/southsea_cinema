import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  testWidgets('Movie card descriptive text uses the light theme foreground', (
    WidgetTester tester,
  ) async {
    final ThemeData lightTheme = ThemeData.light();
    const Movie movie = Movie(
      id: 1,
      title: 'Test Movie',
      ageRating: 'PG',
      description: 'A visible movie description.',
      date: '21/11/2026',
      timeStart: '18:00',
      timeEnd: '20:00',
      price: 10,
      imagePath: 'assets/images/moana.jpg',
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: lightTheme,
        home: Scaffold(
          body: ListView(
            children: const [MovieCard(movie: movie)],
          ),
        ),
      ),
    );

    final Color expectedForeground = lightTheme.colorScheme.onSurface;
    for (final String text in <String>[
      movie.description,
      'BOOK TICKETS',
      '${movie.date} | ${movie.timeStart} - ${movie.timeEnd}',
    ]) {
      final Text textWidget = tester.widget<Text>(find.text(text));
      expect(textWidget.style?.color, expectedForeground);
    }
  });
}
