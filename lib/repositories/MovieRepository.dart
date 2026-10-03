import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return [
      Movie(
        title: 'Dracula (1931)',
        ageRating: 'PG',
        description: 'Please note that Discounts / Membership Benefits will be applied once you have selected your tickets',
        date: 'Thursday 22 Oct 2026',
        timeStart: '18:00',
        timeEnd: '19:14',
        imagePath: 'assets/images/dracula1931picture.jpg',
      ),
      Movie(
        title: 'King Kong',
        ageRating: 'PG',
        description: 'Please note that Discounts / Membership Benifits will be applied once you have selected your tickets',
        date: 'Friday 23 Oct 2026',
        timeStart: '19:00',
        timeEnd: '20:30',
        imagePath: 'assets/images/kongpicture.jpg',
      ),
      // can add more movies here
    ];
  }
}