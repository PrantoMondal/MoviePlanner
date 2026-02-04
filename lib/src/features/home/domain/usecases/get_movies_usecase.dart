import 'package:movie_planner/src/features/home/domain/entities/movie_list_entity.dart';
import 'package:movie_planner/src/features/home/domain/repositories/movie_remote_repo.dart';

class GetMoviesUseCase {
  final MovieRemoteRepo repository;

  GetMoviesUseCase(this.repository);

  Future<MovieListEntity> call({required String category, int page = 1}) async {
    return await repository.getMovies(category: category, page: page);
  }
}
