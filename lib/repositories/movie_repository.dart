import 'package:southsea_cinema/models/movie.dart';

import 'dart:convert'; // provides jsonDecode, which then turns JSON text into dart
// Lists and maps.
import 'package:flutter/services.dart'; // Provides root bundle, an object
// that reads files listened under assets.

class MovieRepository {

  List<Movie>? _cachedMovies;

  List<Movie> getMovies() {
    final List<Movie>? cachedMovies = _cachedMovies;
    if (cachedMovies != null) {
      return cachedMovies;
    }
    
    return [
      Movie(
        id: 1,
        title: 'Dracula (1931)',
        ageRating: 'PG',
        description:
            'The 1931 film "Dracula" is a classic horror film directed by Tod Browning and starring Bela Lugosi as the titular vampire. The film is based on Bram Stokers 1897 novel and the 1924 stage play by Hamilton Deane and John L. Balderston. It follows the story of English solicitor Renfield, who travels to Transylvania to sell a property to Count Dracula, only to find himself entangled in the vampires bloodthirsty ways. The film is notable for being the first sound film adaptation of Bram Stokers novel and has had a significant impact on popular culture, establishing Lugosis portrayal of Dracula as a cultural icon.',
        date: 'Thursday 22 Oct 2026',
        timeStart: '18:00',
        timeEnd: '19:14',
        price: 7.50,
        imagePath: 'assets/images/dracula1931picture.jpg',
      ),
      Movie(
        id: 2,
        title: 'King Kong',
        ageRating: 'PG',
        description:
            'The King Kong character was conceived and created by American filmmaker Merian C. Cooper. In the original film, the characters name is Kong, a name given to him by the inhabitants of the fictional "Skull Island" in the Indian Ocean, where Kong lives along with other oversized animals, such as plesiosaurs, pterosaurs, and various dinosaurs. An American film crew, led by Carl Denham, captures Kong and takes him to New York City to be exhibited as the "Eighth Wonder of the World".',
        date: 'Friday 23 Oct 2026',
        timeStart: '19:00',
        timeEnd: '20:30',
        price: 7.50,
        imagePath: 'assets/images/kongpicture.jpg',
      ),
      // can add more movies here
    ];
  }

  Movie? getMovieById(int id) {
    for (final movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }
    return null;
  }

  Movie? getMovieByAgeRating(String rating) {
    for (final movie in getMovies()) {
      if (movie.ageRating == rating) {
        return movie;
      }
    }
    return null;
  }

  Movie? getMoviesUnderPrice(double maxPrice) {
    for (final movie in getMovies()) {
      if (movie.price < maxPrice) {
        return movie;
      }
    }
    return null;
  }

  Future<List<Movie>> loadMoviesFromAsset({
    String assetPath = 'assets/data/movies.json',
  }) async{
    final String jsonString = await rootBundle.loadString(assetPath);
    final dynamic decodedData = jsonDecode(jsonString);
    final List<dynamic> jsonList = decodedData as List<dynamic>;
    final List<Movie> loadedMovies = [];

    for (final dynamic item in jsonList){
      final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
      final Movie movie = Movie.fromJson(itemMap);
      loadedMovies.add(movie);
    }

    _cachedMovies = loadedMovies;
    return loadedMovies;
  }

}
