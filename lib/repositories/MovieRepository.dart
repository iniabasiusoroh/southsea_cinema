import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return [
      Movie(
        title: 'Dracula (1931) (PG)',
        description: 'Please note that Discounts / Membership Benefits will be applied once you have selected your tickets',
        date: 'Thursday 22 Oct 2026',
        timeStart: '18:00',
        timeEnd: '19:14',
        imagePath: 'assets/images/dracula.jpg',
      ),
      // Add more movies here as needed
    ];
  }
}