import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/notifier/default_change_notifier.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/services/movies/movie_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsController extends DefaultChangeNotifier {
  final MovieService _movieService;
  String? infoMessage;

  bool get hasInfo => infoMessage != null;

  MovieDetailsController({required MovieService movieService})
      : _movieService = movieService;

  Future<void> saveInLibrary(Movie movie) async {
    infoMessage = null;
    showLoadingAndResetState();
    notifyListeners();

    try {
      await _movieService.save(movie);
      success();
    } on Exception catch (e, s) {
      print(e);
      print(s);
      setError(Messages.failedSaveMovies);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> removeFromLibrary(Movie movie) async {
    infoMessage = null;
    showLoadingAndResetState();
    notifyListeners();

    try {
      await _movieService.delete(movie);
      success();
    } on Exception catch (e, s) {
      print(e);
      print(s);
      setError(Messages.failedSaveMovies);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<Movie> loadData(Movie movie) async {
    infoMessage = null;
    showLoadingAndResetState();
    notifyListeners();

    try {
      return await _movieService.fetchMovieDetails(movie);
    } on Exception catch (e, s) {
      print(e);
      print(s);
      setError(Messages.failedSaveMovies);
    } finally {
      hideLoading();
      notifyListeners();
    }

    return movie;
  }

  Future<void> openUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e, s) {
      print(e);
      print(s);
      setError(Messages.failedRedirectExternalURL);
    }
  }
}
