
// Register images in pubspec.yaml (not in this model):
// flutter:
//   assets:
//     - assets/images/
class Movie {
	final String title;
	final String description;
	final DateTime date;
	final DateTime timeStart;
	final DateTime timeEnd;
  final String imagePath; // New field for the image path

	const Movie({
		required this.title,
		required this.description,
		required this.date,
		required this.timeStart,
		required this.timeEnd,
    required this.imagePath, // Initialize the new field
	});
}