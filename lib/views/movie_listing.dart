import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatelessWidget {
  const MovieListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),

    //   Lets us create the body. (putting the movie cards inside the body)
      body: Column(
        children: [
          buildMovieCard('The Christophers', '*Description*'),
          buildMovieCard('Cenesupper', '*Description*'),
          buildMovieCard('Kikuyu Land', '*Description*'),
        ],
      ),
    );
  }
  
  // This function creates a movie card with a title and description.
  Container buildMovieCard(String title, String description) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cinemaSurface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: cinemaBrand, width: 2.0), // Gives each card a border with the cinema brand color.
      ),
      child: Column(
        children:[
          Text(
            title,
            style: const TextStyle(
              color: cinemaFontWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              color: cinemaFontWhite,
              fontSize: 16,
            ),
          ),
          // Two Texts for the title and description of the movie.
        ]
      )
    );
  }
}
