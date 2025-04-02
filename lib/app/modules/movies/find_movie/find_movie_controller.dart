import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/notifier/default_change_notifier.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/services/movies/movie_service.dart';

class FindMovieController extends DefaultChangeNotifier {
  final MovieService _movieService;
  String? infoMessage;

  List<Movie> movies = [];
  var nextPage = 1;
  var totalPages = 1;
  var hasMorePages = false;

  bool get hasInfo => infoMessage != null;

  FindMovieController({required MovieService movieService})
      : _movieService = movieService;

  void incrementPage() => nextPage + 1;

  void resetPage() {
    nextPage = 1;
    movies = [];
  }

  Future<void> findByTitle(String title) async {
    resetPage();

    title.trim();
    if (title.isEmpty) {
      movies = [];
      return;
    }

    await loadData(title);
  }

  Future<void> loadData(String title) async {
    infoMessage = null;
    showLoadingAndResetState();
    notifyListeners();

    try {
      title.trim();
      final response =
          await _movieService.findByTitle(title, nextPage.toString());
      movies.addAll(response.results);
      totalPages = response.totalPages;
      nextPage++;
      hasMorePages = !(nextPage > totalPages);
    } on Exception catch (e, s) {
      print(e);
      print(s);
      setError(Messages.failedFindMovies);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  String getEntirePostUrl(String? posterUrl) =>
      _movieService.getEntirePostUrl(posterUrl);
}
