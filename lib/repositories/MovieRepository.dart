import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return [
      Movie(
        title: 'Dracula (1931)',
        ageRating: 'PG',
        description: 'The 1931 film "Dracula" is a classic horror film directed by Tod Browning and starring Bela Lugosi as the titular vampire. The film is based on Bram Stokers 1897 novel and the 1924 stage play by Hamilton Deane and John L. Balderston. It follows the story of English solicitor Renfield, who travels to Transylvania to sell a property to Count Dracula, only to find himself entangled in the vampires bloodthirsty ways. The film is notable for being the first sound film adaptation of Bram Stokers novel and has had a significant impact on popular culture, establishing Lugosis portrayal of Dracula as a cultural icon.',
        date: 'Thursday 22 Oct 2026',
        timeStart: '18:00',
        timeEnd: '19:14',
        imagePath: 'assets/images/dracula1931picture.jpg',
      ),
      Movie(
        title: 'King Kong',
        ageRating: 'PG',
        description: 'The King Kong character was conceived and created by American filmmaker Merian C. Cooper. In the original film, the characters name is Kong, a name given to him by the inhabitants of the fictional "Skull Island" in the Indian Ocean, where Kong lives along with other oversized animals, such as plesiosaurs, pterosaurs, and various dinosaurs. An American film crew, led by Carl Denham, captures Kong and takes him to New York City to be exhibited as the "Eighth Wonder of the World".',
        date: 'Friday 23 Oct 2026',
        timeStart: '19:00',
        timeEnd: '20:30',
        imagePath: 'assets/images/kongpicture.jpg',
      ),
      // can add more movies here
    ];
  }
}