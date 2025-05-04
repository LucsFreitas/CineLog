import 'package:cine_log/app/core/notifier/default_change_notifier.dart';
import 'package:cine_log/app/exceptions/auth_exception.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/modules/home/home_page_movie_list_tab.dart';
import 'package:cine_log/app/services/movies/movie_service.dart';

class HomeController extends DefaultChangeNotifier {
  final MovieService _movieService;

  HomeController({
    required MovieService movieService,
  }) : _movieService = movieService;

  Future<List<Movie>> findAll(MovieFilter filter, String? movieName) async {
    showLoadingAndResetState();
    notifyListeners();

    try {
      bool watched = MovieFilter.toWatch == filter ? false : true;
      final movies = await _movieService.findAll(watched, movieName);
      return movies;
    } on AuthException catch (e) {
      setError(e.message);
      return List<Movie>.empty();
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
