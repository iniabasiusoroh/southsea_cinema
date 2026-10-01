import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(color: Colors.red, width: 2.0), // Gives each card a border with the cinema brand color.
      ),
      child: Column(
        children:[
          Text(
            movie.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Southsea Cinema Room',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,  
            ),
          ),
          Text(
            '${movie.date} | ${movie.timeStart} - ${movie.timeEnd}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,  
            ),
          ),
          const SizedBox(height: 12),
          Text(
            movie.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,  
            ),
          ),
          const SizedBox(height: 12),
          Image.asset(movie.imagePath),
        ],
      ),
    );
  }
}