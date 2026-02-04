import 'package:movie_planner/src/features/home/data/datasources/movie_remote_datasource.dart';
import 'package:movie_planner/src/features/home/data/mappers.dart';
import 'package:movie_planner/src/features/home/domain/entities/movie_list_entity.dart';
import 'package:movie_planner/src/features/home/domain/repositories/movie_remote_repo.dart';

class MovieRemoteRepoImpl implements MovieRemoteRepo {
  final MovieRemoteDatasource remoteDataSource;

  MovieRemoteRepoImpl(this.remoteDataSource);

  @override
  Future<MovieListEntity> getMovies({required String category, required int page}) async {
    final response = await remoteDataSource.fetchMovies(category: category, page: page);

    return MovieListEntity(
      page: response.page,
      results: MovieMapper.toEntityList(response.results),
      totalPages: response.totalPages,
      totalResults: response.totalResults,
    );
  }
}
