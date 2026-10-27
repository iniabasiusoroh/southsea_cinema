import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main(){
  group('Movie Model Test', (){
    test('Movie model should have correct properties', () {
      final movie = Movie(
        id: 1,
        title: 'Dracula (1931)',
        ageRating: 'PG',
        description: 'The 1931 film "Dracula" is a classic horror film directed by Tod Browning and starring Bela Lugosi as the titular vampire. The film is based on Bram Stokers 1897 novel and the 1924 stage play by Hamilton Deane and John L. Balderston. It follows the story of English solicitor Renfield, who travels to Transylvania to sell a property to Count Dracula, only to find himself entangled in the vampires bloodthirsty ways. The film is notable for being the first sound film adaptation of Bram Stokers novel and has had a significant impact on popular culture, establishing Lugosis portrayal of Dracula as a cultural icon.',
        date: 'Thursday 22 Oct 2026',
        timeStart: '18:00',
        timeEnd: '19:14',
        price: 7.50,
        imagePath: 'assets/images/dracula1931picture.jpg',
      );

      expect(movie.id, 1);
      expect(movie.title, 'Dracula (1931)');
      expect(movie.ageRating, 'PG');
      expect(movie.description, contains('classic horror film'));
      expect(movie.date, 'Thursday 22 Oct 2026');
      expect(movie.timeStart, '18:00');
      expect(movie.timeEnd, '19:14');
      expect(movie.price, 7.50);
      expect(movie.imagePath, 'assets/images/dracula1931picture.jpg');
    });

    test('formattedPrice should return price in correct format', () {
      final movie = Movie(
        id: 1,
        title: 'Dracula (1931)',
        ageRating: 'PG',
        description: 'The 1931 film "Dracula" is a classic horror film directed by Tod Browning and starring Bela Lugosi as the titular vampire. The film is based on Bram Stokers 1897 novel and the 1924 stage play by Hamilton Deane and John L. Balderston. It follows the story of English solicitor Renfield, who travels to Transylvania to sell a property to Count Dracula, only to find himself entangled in the vampires bloodthirsty ways. The film is notable for being the first sound film adaptation of Bram Stokers novel and has had a significant impact on popular culture, establishing Lugosis portrayal of Dracula as a cultural icon.',
        date: 'Thursday 22 Oct 2026',
        timeStart: '18:00',
        timeEnd: '19:14',
        price: 7.50,
        imagePath: 'assets/images/dracula1931picture.jpg',
      );

      expect(movie.formattedPrice, '£7.50');
    });

    test('isChildFriendly should return true for U and PG ratings', () {
      final movie1 = Movie(
        id: 1,
        title: 'Movie 1',
        ageRating: 'U',
        description: 'Description 1',
        date: 'Date 1',
        timeStart: 'Time Start 1',
        timeEnd: 'Time End 1',
        price: 5.00,
        imagePath: 'assets/images/movie1.jpg',
      );

      final movie2 = Movie(
        id: 2,
        title: 'Movie 2',
        ageRating: 'PG',
        description: 'Description 2',
        date: 'Date 2',
        timeStart: 'Time Start 2',
        timeEnd: 'Time End 2',
        price: 6.00,
        imagePath: 'assets/images/movie2.jpg',
      );

      final movie3 = Movie(
        id: 3,
        title: 'Movie 3',
        ageRating: '18',
        description: 'Description 3',
        date: 'Date 3',
        timeStart: 'Time Start 3',
        timeEnd: 'Time End 3',
        price: 8.00,
        imagePath: 'assets/images/movie3.jpg',
      );

      expect(movie1.isChildFriendly, true);
      expect(movie2.isChildFriendly, true);
      expect(movie3.isChildFriendly, false);
    });

    test ('isAdultOnly should return true for 18 rating', () {
      final movie1 = Movie(
        id: 1,
        title: 'Movie 1',
        ageRating: 'U',
        description: 'Description 1',
        date: 'Date 1',
        timeStart: 'Time Start 1',
        timeEnd: 'Time End 1',
        price: 5.00,
        imagePath: 'assets/images/movie1.jpg',
      );

      final movie2 = Movie(
        id: 2,
        title: 'Movie 2',
        ageRating: 'PG',
        description: 'Description 2',
        date: 'Date 2',
        timeStart: 'Time Start 2',
        timeEnd: 'Time End 2',
        price: 6.00,
        imagePath: 'assets/images/movie2.jpg',
      );

      final movie3 = Movie(
        id: 3,
        title: 'Movie 3',
        ageRating: '18',
        description: 'Description 3',
        date: 'Date 3',
        timeStart: 'Time Start 3',
        timeEnd: 'Time End 3',
        price: 8.00,
        imagePath: 'assets/images/movie3.jpg',
      );

      expect(movie1.isAdultOnly, false);
      expect(movie2.isAdultOnly, false);
      expect(movie3.isAdultOnly, true);
    });
    
    test('JSON conversion preserves each movie field', (){
      final Map<String, dynamic> data = <String, dynamic>{
        'id': 1,
        'title': 'testMovie',
        'ageRating': 'PG',
        'description': 'A relaxing movie',
        'date': 'Monday 1st January 2025',
        'timeStart': '20:00',
        'timeEnd': '21:30',
        'price': 7.50,
        'imagePath': 'testImagePath',
      };

      final Movie movie = Movie.fromJson(data);
      expect(movie.id, 1);
      expect(movie.title, 'testMovie');
      expect(movie.ageRating, 'PG');
      expect(movie.description, 'A relaxing movie');
      expect(movie.date, 'Monday 1st January 2025');
      expect(movie.timeStart, '20:00');
      expect(movie.timeEnd, '21:30');
      expect(movie.price, 7.50);
      expect(movie.imagePath, 'testImagePath');
    });

    test('fromJson accepts a whole-number price', (){
      final Map<String, dynamic> data = <String, dynamic>{
        'id': 1,
        'title': 'testMovie',
        'ageRating': 'PG',
        'description': 'A relaxing movie',
        'date': 'Monday 1st January 2025',
        'timeStart': '20:00',
        'timeEnd': '21:30',
        'price': 7,
        'imagePath': 'testImagePath',
      };
      final Movie movie = Movie.fromJson(data);
      expect(movie.price, 7.0);
      expect(movie.price, isA<double>());
      // COME BACK AND CHECK THIS ???????????????????????????????
    });
  });
}