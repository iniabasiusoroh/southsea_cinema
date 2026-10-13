import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/MovieRepository.dart';

void main() {
  group('Movie Repository Tests', () {

    // Checks that the repository can return a list of movie objects.
    test('Returns a list of movies', () {
      final repository = MovieRepository();
      final movies = repository.getMovies();
      expect(movies, isA<List<Movie>>());
    });

    test('Returns the correct movie given an existing identifier', () {
      final repository = MovieRepository();
      final movies = repository.getMovies();

      final expectedMovie = movies.first;
      final movie = repository.getMovieById(expectedMovie.id);

      expect(movie, isNotNull);
      expect(movie!.id, expectedMovie.id);
});


    test('getMovieByAgeRating verification', () {
      final repository = MovieRepository();
      const testAgeRating = 'PG';

      final expectedResult = "Dracula (1931)";
      final movieResults = repository.getMovieByAgeRating(testAgeRating);

      expect(movieResults?.title, expectedResult);

    });

    test('getMoviesUnderPrice verification', (){
    });

  });
}