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
          buildMovieCard('Dracula (1931) (PG)', '*Description*', 'Thursday 22 Oct 2026', '19:00'),
          // buildMovieCard('Cenesupper', '*Description*'),
          // buildMovieCard('Kikuyu Land', '*Description*'),
        ],
      ),
    );
  }
  
  // This function creates a movie card with a title and description.
  Container buildMovieCard(String title, String description, String date, String timeStart) {
    return Container(
      alignment: Alignment.topLeft,

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
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Southsea Cinema Room',
            style: const TextStyle(
              color: cinemaFontWhite,
              fontSize: 16,
              
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
