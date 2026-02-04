import 'movie_entity.dart';

class MovieListEntity {
  final int page;
  final List<MovieEntity> results;
  final int totalPages;
  final int totalResults;

  const MovieListEntity({
    this.page = 0,
    this.results = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });
}
