part of 'movie_details_bloc.dart';

class MovieDetailsState extends BaseState {
  final MovieDetailsEntity? details;

  const MovieDetailsState({
    super.isLoading,
    super.error,
    this.details,
  });

  MovieDetailsState copyWith({
    bool? isLoading,
    String? error,
    bool clearError = false,
    MovieDetailsEntity? details,
  }) {
    return MovieDetailsState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      details: details ?? this.details,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, details];
}
