import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {

  TestWidgetsFlutterBinding.ensureInitialized();
  group('Movie Repository Tests', () {

    // Checks that the repository can return a list of movie objects.
    test('Returns a list of movies', () {
      final MovieRepository repository = MovieRepository();
      final movies = repository.getMovies();
      expect(movies, isA<List<Movie>>());
    });

    test('Returns the correct movie given an existing identifier', () {
      final MovieRepository repository = MovieRepository();
      final movies = repository.getMovies();

      final expectedMovie = movies.first;
      final movie = repository.getMovieById(expectedMovie.id);

      expect(movie, isNotNull);
      expect(movie!.id, expectedMovie.id);
});


    test('getMovieByAgeRating verification', () {
      final MovieRepository repository = MovieRepository();
      const testAgeRating = 'PG';

      final expectedResult = "Dracula (1931)";
      final movieResults = repository.getMovieByAgeRating(testAgeRating);

      expect(movieResults?.title, expectedResult);

    });

    test('getMoviesUnderPrice verification', (){
      final MovieRepository repository = MovieRepository();
      const testPrice = 8.00;

      final expectedResult = "Dracula (1931)";
      final movieResults = repository.getMoviesUnderPrice(testPrice);

      expect(movieResults?.title, expectedResult);
    });

    test('getMovieById returns matching movie when id exists', (){
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById(1);

      expect(movie, isNotNull);
      expect(movie?.title, 'Dracula (1931)');
      expect(movie?.ageRating, 'PG');
      expect(movie?.price, 7.50);
    });

    test('getMovieById returns null when id does not exist', (){
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById(100);

      expect(movie, isNull);

    });

    test ('loadMoviesFromAssets reads the bundled JSON menu', () async {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = await repository.loadMoviesFromAsset();

      expect(movies[0].title, 'Dracula (1931)');
      expect(movies[1].id, 2);
      expect(movies[1]. ageRating, 'PG');
      expect(movies[1].imagePath, "assets/images/kongpicture.jpg");
      expect(repository.getMovies(), movies);
      expect(movies[2].title, "Moana");

    });

  });
}