import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/MovieRepository.dart';

void main() {
  group('Movie Repository Tests', () {
    test('returns a list of movies', () {
      final repository = MovieRepository();
      final movies = repository.getMovies();

      expect(movies, isA<List<Movie>>());
    });
  });
}