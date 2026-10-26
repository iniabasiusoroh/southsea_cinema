// Register images in pubspec.yaml (not in this model):
// flutter:
//   assets:
//     - assets/images/

class Movie {
  final int id;
  final String title;
  final String ageRating;
  final String description;
  final String date;
  final String timeStart;
  final String timeEnd;
  final double price;
  final String imagePath; // New field for the image path

  const Movie({
    required this.id,
    required this.title,
    required this.ageRating,
    required this.description,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.price,
    required this.imagePath, // Initialize the new field
  });


  String get formattedPrice => '£${price.toStringAsFixed(2)}';

  bool get isChildFriendly => ageRating == 'U' || ageRating == 'PG';

  bool get isAdultOnly => ageRating == '18';

  factory Movie.fromJson(Map<String, dynamic> json) {
    final int id = json['id'] as int;
    final String title = json['title'] as String;
    final String ageRating = json['ageRating'] as String;
    final String description = json['description'] as String;
    final String date = json['date'] as String;
    final String timeStart = json['timeStart'] as String;
    final String timeEnd = json['timeEnd'] as String;
    final double price = json['price'] as double;
    final String imagePath = json['imagePath'] as String;

    return Movie(
      id: id,
      title: title,
      ageRating: ageRating,
      description: description,
      date: date,
      timeStart: timeStart,
      timeEnd: timeEnd,
      price: price,
      imagePath: imagePath,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {
      'id': id,
      'title': title,
      'ageRating': ageRating,
      'description': description,
      'date': date,
      'timeStart': timeStart,
      'timeEnd': timeEnd,
      'price': price,
      'imagePath': imagePath
    };
    return data;
  }

}
