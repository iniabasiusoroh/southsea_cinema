class OrderItem {
  final int movieId;
  final String title;
  final String ageRating;
  final String description;
  final String date;
  final String timeStart;
  final String timeEnd;
  final double unitPrice;
  final int quantity;

  const OrderItem({
    required this.movieId,
    required this.title,
    required this.ageRating,
    required this.description,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.unitPrice,
    required this.quantity,
  });

  Map<String, Object?> toMap({required int orderId}) {
    return <String, Object?>{
      'order_id': orderId,
      'movie_id': movieId,
      'title': title,
      'age_rating': ageRating,
      'description': description,
      'show_date': date,
      'time_start': timeStart,
      'time_end': timeEnd,
      'unit_price': unitPrice,
      'quantity': quantity,
    };
  }

  factory OrderItem.fromMap(Map<String, Object?> map) {
    final num unitPrice = map['unit_price'] as num;
    return OrderItem(
      movieId: map['movie_id'] as int,
      title: map['title'] as String,
      ageRating: map['age_rating'] as String,
      description: map['description'] as String,
      date: map['show_date'] as String,
      timeStart: map['time_start'] as String,
      timeEnd: map['time_end'] as String,
      unitPrice: unitPrice.toDouble(),
      quantity: map['quantity'] as int,
    );
  }
}

class OrderRecord {
  final int? id;
  final int bookingNumber;
  final String summary;
  final double total;
  final String date;
  final List<OrderItem> items;

  const OrderRecord(
      {this.id,
      required this.bookingNumber,
      required this.summary,
      required this.total,
      required this.date,
      this.items = const <OrderItem>[]});

  Map<String, Object?> toMap() {
    final Map<String, Object?> data = <String, Object?>{
      'booking_number': bookingNumber,
      'summary': summary,
      'total': total,
      'date': date
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }

  factory OrderRecord.fromMap(Map<String, Object?> map) {
    final int bookingNumber = map['booking_number'] as int;
    final String summary = map['summary'] as String;
    final num totalNumber = map['total'] as num;
    final double total = totalNumber.toDouble();
    final String date = map['date'] as String;

    return OrderRecord(
      id: map['id'] as int?,
      bookingNumber: bookingNumber,
      summary: summary,
      total: total,
      date: date,
    );
  }
}
