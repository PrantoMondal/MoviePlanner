import 'package:movie_planner/src/features/home/domain/entities/movie_list_entity.dart';

abstract class MovieRemoteRepo {
  Future<MovieListEntity> getMovies({required String category, required int page});
}
