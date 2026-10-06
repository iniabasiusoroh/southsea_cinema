import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: movie.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' (${movie.ageRating})',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Image.asset(movie.imagePath),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  movie.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'BOOK TICKETS',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,  
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  '${movie.date} | ${movie.timeStart} - ${movie.timeEnd}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,  
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieListing(movie: movie),
                    )
                  )
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Book now'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

/* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieListingView(movie: movie),
                ),
              ); */