import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';
import 'package:southsea_cinema/models/cart_item.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({
    super.key,
    required this.movie,
    });

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int selectedQuantity = 0;

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
          buildMovieCard(
            widget.movie.title,
            widget.movie.description,
            widget.movie.date,
            widget.movie.timeStart,
            widget.movie.timeEnd,
            widget.movie.price,
          )
        ],
      ),
    );
  }
  

  // This function creates a movie card with a title and description.
  Container buildMovieCard(String title, String description, String date, String timeStart, String timeEnd, dynamic price) {
    return Container(
      alignment: Alignment.center,

      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cinemaSurface,
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(color: cinemaBrand, width: 2.0), // Gives each card a border with the cinema brand color.
      ),
      child: Column(
        children:[
          Text(
            title,
            style: const TextStyle(
              color: cinemaFontWhite,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Southsea Cinema Room',
            style: const TextStyle(
              color: cinemaFontWhite,
              fontSize: 16,  
            ),
          ),
          Text(
            '$date, $timeStart - ends at $timeEnd',
            style: const TextStyle(
              color: cinemaFontWhite,
              fontSize: 16,  
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: cinemaFontWhite,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Select Quantities (Up to 5 in total)',
            style: const TextStyle(
              color: cinemaFontWhite,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Tickets',
            style: const TextStyle(
              color: cinemaFontWhite,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownMenu<int>(
                initialSelection: 0,
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: 0, label: '0'),
                  DropdownMenuEntry(value: 1, label: '1'),
                  DropdownMenuEntry(value: 2, label: '2'),
                  DropdownMenuEntry(value: 3, label: '3'),
                  DropdownMenuEntry(value: 4, label: '4'),
                  DropdownMenuEntry(value: 5, label: '5'),
                ],
                onSelected: (int? value) {
                  if (value != null) {
                    setState(() => selectedQuantity = value);
                  }
                },
              ),
              const SizedBox(width: 12),
              Text(
                'Adult £$price',
                style: const TextStyle(color: cinemaFontWhite, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            label: "Add to Order",
            onPressed: () {
              if (selectedQuantity == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select at least one ticket.')),
                );
                return;
              }

              CartRepository.instance.addItem(
                CartItem(movie: widget.movie, title: widget.movie.title, quantity: selectedQuantity, date: widget.movie.date, timeEnd: widget.movie.timeEnd, timeStart: widget.movie.timeStart),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tickets added to your order.')),
              );
            },
          )
          // ElevatedButton(
          //   onPressed: () {
          //     // Add the action to perform when this button is pressed.
          //   },
          //   child: const Text('Add to Order'),
          // ),
        ]
      )
    ); 
  }
}
