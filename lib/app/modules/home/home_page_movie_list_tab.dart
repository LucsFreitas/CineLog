import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/widget/movie_card_vertical.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/modules/home/home_controller.dart';
import 'package:cine_log/app/modules/movies/movie_details/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum MovieFilter { toWatch, watched }

class MovieListTab extends StatefulWidget {
  final MovieFilter filter;

  const MovieListTab({super.key, required this.filter});

  @override
  State<MovieListTab> createState() => _MovieListTabState();
}

class _MovieListTabState extends State<MovieListTab> {
  List<Movie> movies = List.empty();

  @override
  void initState() {
    super.initState();

    Future.microtask(() async => await fetchMovies());
  }

  Future<void> fetchMovies() async {
    final fetchedMovies =
        await context.read<HomeController>().findAll(widget.filter, null);
    setState(() {
      movies = fetchedMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: fetchMovies,
      child: movies.isEmpty
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.filter == MovieFilter.toWatch
                        ? Messages.defaultTextToWatchTab
                        : Messages.defaultTextWatchedTab,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : GridView.builder(
              itemCount: movies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / 3,
              ),
              padding: const EdgeInsets.only(top: 5),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCardVertical(
                  movie: movie,
                  onTap: () => Navigator.of(context).pushNamed(
                    '/movie_details',
                    arguments: {
                      'movie': movie,
                      'action': widget.filter == MovieFilter.toWatch
                          ? MovieAction.markAsWatched
                          : MovieAction.reAddToLibrary
                    },
                  ),
                );
              },
            ),
    );
  }
}
