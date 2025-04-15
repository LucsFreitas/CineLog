import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/notifier/default_change_notifier.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/services/movies/movie_service.dart';

class MovieDetailsController extends DefaultChangeNotifier {
  final MovieService _movieService;
  String? infoMessage;

  bool get hasInfo => infoMessage != null;

  MovieDetailsController({required MovieService movieService})
      : _movieService = movieService;

  String getEntirePostUrl(String? posterUrl) =>
      _movieService.getEntirePostUrl(posterUrl);

  Future<void> saveInLibrary(Movie movie) async {
    infoMessage = null;
    showLoadingAndResetState();
    notifyListeners();

    try {
      await _movieService.save(movie);
    } on Exception catch (e, s) {
      print(e);
      print(s);
      setError(Messages.failedSaveMovies);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
