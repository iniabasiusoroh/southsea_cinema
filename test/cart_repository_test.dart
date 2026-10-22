import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';

const Movie testMovie1 = Movie(
	id: 1,
	title: 'The Last Voyage',
	ageRating: 'PG',
	description: 'A crew sets out on a journey across the stars.',
	date: '2025-06-15',
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
	date: '2025-06-16',
	timeStart: '17:30',
	timeEnd: '19:30',
	price: 14.00,
	imagePath: 'assets/images/midnight_mystery.jpg',
);

const Movie testMovie3 = Movie(
	id: 3,
	title: 'Summer at the Shore',
	ageRating: 'U',
	description: 'A family discovers adventure during a seaside holiday.',
	date: '2025-06-17',
	timeStart: '20:00',
	timeEnd: '21:45',
	price: 10.50,
	imagePath: 'assets/images/summer_at_the_shore.jpg',
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
      expect(cart.getSubtotal(), 0.0);
    });

    test('adds items and calculates subtotal correctly', (){
      final CartRepository cart = CartRepository.instance;

      const CartItem cartItem1 = CartItem(movie: testMovie1, quantity: 2);
      const CartItem cartItem2 = CartItem(movie: testMovie2, quantity: 3);

			cart.addItem(cartItem1);
			cart.addItem(cartItem2);

			expect(cart.getItems(), [cartItem1, cartItem2]);
			expect(cart.getTotalItems(), 5);
			expect(cart.totalItemCount, 5);
			expect(cart.getSubtotal(), 67.0);
    });

  });

}