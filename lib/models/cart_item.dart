import 'package:southsea_cinema/models/movie.dart';

class CartItem {
  final Movie movie;
  final String title;
  final int quantity;
  final String timeStart;
  final String timeEnd;
  final String date;

  const CartItem({
    required this.movie,
    required this.title,
    required this.quantity,
    required this.timeStart,
    required this.timeEnd,
    required this.date,
  });

  double get lineTotal{
    return movie.price * quantity.toDouble();
  }
}