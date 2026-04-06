import 'package:equatable/equatable.dart';

class MovieDetailsEntity extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double rating;

  MovieDetailsEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, title, overview, posterPath, releaseDate, rating];
}
