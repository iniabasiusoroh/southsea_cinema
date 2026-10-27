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
    final Widget body;
    if(_loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_errorMessage.isNotEmpty) {
      body = Center(child: Text(_errorMessage));
    } else {
      body = ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (BuildContext context, int index) {
          return MovieCard(movie: _movies[index]);
        },
      );
    }
    



    // final movieRepository = MovieRepository();
    // final movies = movieRepository.getMovies();

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: body
    );
  }
}