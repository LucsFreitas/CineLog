class ApiUrls {
  static final String _searchMovieUrl =
      'https://api.themoviedb.org/3/search/movie';
  static final String _movieDetailsUrl =
      'https://api.themoviedb.org/3/search/movie';
  static final String _posterBaseUrl = 'https://image.tmdb.org/t/p/w342';
  static final String _backdropUrl = 'https://image.tmdb.org/t/p/w500';

  static String searchMovie() {
    return _searchMovieUrl;
  }

  static String movieDetails(int id) {
    return _movieDetailsUrl;
  }

  static String posterUrl(String? posterPath) {
    if (posterPath == null) return '';
    return '$_posterBaseUrl$posterPath';
  }

  static String backdropUrl(String? backdropPath) {
    if (backdropPath == null) return '';
    return '$_backdropUrl$backdropPath';
  }
}
