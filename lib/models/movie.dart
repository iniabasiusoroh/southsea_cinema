
// Register images in pubspec.yaml (not in this model):
// flutter:
//   assets:
//     - assets/images/
class Movie {
	final String title;
  final String ageRating;
	final String description;
	final String date;
	final String timeStart;
	final String timeEnd;
  final double price;
  final String imagePath; // New field for the image path

	const Movie({
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




}
