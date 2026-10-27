import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<Movie> _movies = [];
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadSandwiches();
  }

  Future<void> _loadSandwiches() async {
    try {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = 
        await repository.loadMoviesFromAsset();
      if (!mounted) {
        return;
      }
      setState((){
        _movies = movies;
        _loading = false;
      });
    }  catch(error) {
      if (!mounted){
        return;
      }
      setState((){
        _errorMessage = 'Could not load menu: $error';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieRepository = MovieRepository();
    final movies = movieRepository.getMovies();

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCard(movie: movie);
        },
      ),
    );
  }
}