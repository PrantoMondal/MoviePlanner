import 'package:movie_planner/src/features/home/data/models/movie.dart';

class MovieListResponse {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  MovieListResponse({
    this.page = 0,
    this.results = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });

  factory MovieListResponse.fromJson(Map<String, dynamic> json) {
    return MovieListResponse(
      page: json['page'] ?? 0,
      results:
          (json['results'] as List<dynamic>?)?.map((e) => Movie.fromJson(e)).toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}
