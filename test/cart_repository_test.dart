import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';

const Movie testMovie1 = Movie(
	id: 1,
	title: 'The Last Voyage',
	ageRating: 'PG',
	description: 'A crew sets out on a journey across the stars.',
	date: 'Monday 12th November 2026',
	timeStart: '14:00',
	timeEnd: '16:00',
	price: 12.50,
	imagePath: 'assets/images/the_last_voyage.jpg',
);

const Movie testMovie2 = Movie(
	id: 2,
	title: 'Midnight Mystery',
	ageRating: '12A',
	description: 'A detective investigates a mysterious disappearance.',
  date: 'Monday 11th November 2026',
	timeStart: '17:30',
	timeEnd: '19:30',
	price: 14.00,
	imagePath: 'assets/images/midnight_mystery.jpg',
);


void main() {
  setUp((){
    CartRepository.instance.clear();
  });

  group('CartRepository tests', () {
    test('starts with empty basket and zero totals', () {
      final CartRepository cart = CartRepository.instance;
      expect(cart.getItems().length, 0);
      expect(cart.getTotalItems(), 0);
      expect(cart.totalItemCount, 0);
      expect(cart.getTotal(), 0.0);
    });

    test('adds items and calculates subtotal correctly', (){
      final CartRepository cart = CartRepository.instance;

      CartItem cartItem1 = CartItem(movie: testMovie1, title: testMovie1.title, quantity: 2, date: testMovie1.date, timeEnd: testMovie1.timeEnd, timeStart: testMovie1.timeStart);
      CartItem cartItem2 = CartItem(movie: testMovie2, title: testMovie2.title, quantity: 3, date: testMovie2.date, timeEnd: testMovie2.timeEnd, timeStart: testMovie2.timeStart);

			cart.addItem(cartItem1);
			cart.addItem(cartItem2);

			expect(cart.getItems(), [cartItem1, cartItem2]);
			expect(cart.getTotalItems(), 5);
			expect(cart.totalItemCount, 5);
			expect(cart.getTotal(), 67.0);
    });

    test('removes items correctly', (){
      final CartRepository cart = CartRepository.instance;

      CartItem cartItem1 = CartItem(movie: testMovie1, title: testMovie1.title, quantity: 1, date: testMovie1.date, timeEnd: testMovie1.timeEnd, timeStart: testMovie1.timeStart);
      CartItem cartItem2 = CartItem(movie: testMovie2, title: testMovie2.title, quantity: 1, date: testMovie2.date, timeEnd: testMovie2.timeEnd, timeStart: testMovie2.timeStart);

      cart.addItem(cartItem1);
			cart.addItem(cartItem2);

      expect(cart.getItems(), [cartItem1, cartItem2]);
      expect(cart.getTotalItems(), 2);

      cart.removeItem(0);

      expect(cart.getItems(), [cartItem2]);
      expect(cart.getTotalItems(), 1);
    });

  });

}