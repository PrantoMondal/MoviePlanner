// temp_movie.dart
class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final double voteAverage;
  final String releaseDate;
  final List<int> genreIds;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
    this.genreIds = const [],
  });

  // Helper to get full poster URL
  String get fullPosterPath => 'https://image.tmdb.org/t/p/w500$posterPath';

  // Temporary factory for testing
  factory Movie.temp({
    int? id,
    String? title,
    String? posterPath,
    String? overview,
    double? voteAverage,
    String? releaseDate,
  }) {
    return Movie(
      id: id ?? 1,
      title: title ?? 'Sample Movie',
      posterPath: posterPath ?? '/sample.jpg',
      overview: overview ?? 'This is a sample movie overview.',
      voteAverage: voteAverage ?? 7.5,
      releaseDate: releaseDate ?? '2024-01-01',
    );
  }
}
