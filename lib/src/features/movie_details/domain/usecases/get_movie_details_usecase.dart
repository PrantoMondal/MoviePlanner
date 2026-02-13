import 'package:movie_planner/src/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:movie_planner/src/features/movie_details/domain/repositories/movie_details_repo.dart';

class GetMovieDetailsUseCase {
  final MovieDetailsRepo repository;

  GetMovieDetailsUseCase(this.repository);

  Future<MovieDetailsEntity> call(int movieId) {
    return repository.getMovieDetails(movieId);
  }
}
