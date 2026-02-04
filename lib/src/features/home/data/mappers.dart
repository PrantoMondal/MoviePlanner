import 'package:movie_planner/src/features/home/data/models/movie.dart';
import 'package:movie_planner/src/features/home/domain/entities/movie_entity.dart';

class MovieMapper {
  static MovieEntity toEntity(Movie model) {
    return MovieEntity(
      adult: model.adult,
      backdropPath: model.backdropPath,
      genreIds: model.genreIds,
      id: model.id,
      originalLanguage: model.originalLanguage,
      originalTitle: model.originalTitle,
      overview: model.overview,
      popularity: model.popularity,
      posterPath: model.posterPath,
      releaseDate: model.releaseDate,
      title: model.title,
      video: model.video,
      voteAverage: model.voteAverage,
      voteCount: model.voteCount,
    );
  }

  static Movie toModel(MovieEntity entity) {
    return Movie(
      adult: entity.adult,
      backdropPath: entity.backdropPath,
      genreIds: entity.genreIds,
      id: entity.id,
      originalLanguage: entity.originalLanguage,
      originalTitle: entity.originalTitle,
      overview: entity.overview,
      popularity: entity.popularity,
      posterPath: entity.posterPath,
      releaseDate: entity.releaseDate,
      title: entity.title,
      video: entity.video,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
    );
  }

  static List<MovieEntity> toEntityList(List<Movie> models) {
    return models.map((model) => toEntity(model)).toList();
  }
}
