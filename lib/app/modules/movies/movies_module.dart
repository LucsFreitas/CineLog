import 'package:cine_log/app/core/modules/base_module.dart';
import 'package:cine_log/app/modules/movies/find_movie/find_movie_controller.dart';
import 'package:cine_log/app/modules/movies/find_movie/find_movie_page.dart';
import 'package:provider/provider.dart';

class MoviesModule extends BaseModule {
  MoviesModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (context) =>
                  FindMovieController(movieService: context.read()),
            ),
          ],
          routers: {
            '/find_movie': (context) => FindMoviePage(),
          },
        );
}
