class ApiUrls {
  static final String _baseUrl = 'https://api.themoviedb.org/3';
  static final String _searchMovieUrl = '/search/movie';
  static final String _movieDetailsUrl = '/movie/{movie_id}';
  static final String _watchProvidersUrl = '/movie/{movie_id}/watch/providers';
  static final String _posterBaseUrl = 'https://image.tmdb.org/t/p/w342';
  static final String _backdropUrl = 'https://image.tmdb.org/t/p/w500';
  static final String _logoUrl = 'https://image.tmdb.org/t/p/w92';

  static String searchMovie() {
    return '$_baseUrl$_searchMovieUrl';
  }

  static String movieDetails(int id) {
    return '$_baseUrl$_movieDetailsUrl'.replaceAll('{movie_id}', id.toString());
  }

  static String watchProvidersUrl(int id) {
    return '$_baseUrl$_watchProvidersUrl'
        .replaceAll('{movie_id}', id.toString());
  }

  static String posterUrl(String? posterPath) {
    if (posterPath == null) return '';
    return '$_posterBaseUrl$posterPath';
  }

  static String backdropUrl(String? backdropPath) {
    if (backdropPath == null) return '';
    return '$_backdropUrl$backdropPath';
  }

  static String logoUrl(String? logoPath) {
    if (logoPath == null) return '';
    return '$_logoUrl$logoPath';
  }
}
