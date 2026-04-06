import 'package:movie_planner/src/features/movie_details/data/datasources/movie_details_remote_datasource.dart';
import 'package:movie_planner/src/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:movie_planner/src/features/movie_details/domain/repositories/movie_details_repo.dart';

class MovieDetailsRepoImpl implements MovieDetailsRepo {
  final MovieDetailsRemoteDatasource remoteDatasource;

  MovieDetailsRepoImpl(this.remoteDatasource);

  @override
  Future<MovieDetailsEntity> getMovieDetails(int movieId) async {
    final model = await remoteDatasource.fetchMovieDetails(movieId);

    return MovieDetailsEntity(
      id: model.id,
      title: model.title,
      overview: model.overview,
      posterPath: model.posterPath,
      releaseDate: model.releaseDate,
      rating: model.rating,
    );
  }
}
