import 'package:cine_log/app/core/modules/base_module.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/modules/movies/find_movie/find_movie_controller.dart';
import 'package:cine_log/app/modules/movies/find_movie/find_movie_page.dart';
import 'package:cine_log/app/modules/movies/movie_details/movie_details_controller.dart';
import 'package:cine_log/app/modules/movies/movie_details/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviesModule extends BaseModule {
  MoviesModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (context) =>
                  FindMovieController(movieService: context.read()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  MovieDetailsController(movieService: context.read()),
            ),
          ],
          routers: {
            '/find_movie': (context) => FindMoviePage(),
            '/movie_details': (context) {
              final movie = ModalRoute.of(context)!.settings.arguments as Movie;
              return MovieDetailsPage(movie: movie);
            },
          },
        );
}
