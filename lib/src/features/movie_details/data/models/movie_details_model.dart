class MovieDetailsModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double rating;

  const MovieDetailsModel({
    this.id = 0,
    this.title = '',
    this.overview = '',
    this.posterPath = '',
    this.releaseDate = '',
    this.rating = 0.0,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      rating: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'vote_average': rating,
    };
  }
}
