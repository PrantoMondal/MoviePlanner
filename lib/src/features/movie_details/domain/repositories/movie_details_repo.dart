import 'package:movie_planner/src/features/movie_details/domain/entities/movie_details_entity.dart';

abstract class MovieDetailsRepo {
  Future<MovieDetailsEntity> getMovieDetails(int movieId);
}