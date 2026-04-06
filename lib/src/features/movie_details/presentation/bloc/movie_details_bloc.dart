import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/src/core/base/base_bloc.dart';
import 'package:movie_planner/src/core/base/base_event.dart';
import 'package:movie_planner/src/core/base/base_state.dart';
import 'package:movie_planner/src/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:movie_planner/src/features/movie_details/domain/usecases/get_movie_details_usecase.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends BaseBloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;

  MovieDetailsBloc(this.getMovieDetailsUseCase) : super(const MovieDetailsState()) {
    on<FetchMovieDetails>(_onFetchMovieDetails);
  }

  Future<void> _onFetchMovieDetails(
    FetchMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    await safeEmit(
      emit,
      () async {
        final MovieDetailsEntity details = await getMovieDetailsUseCase(event.movieId);
        return state.copyWith(isLoading: false, details: details, clearError: true);
      },
      onError: (error) => state.copyWith(isLoading: false, error: error),
    );
  }
}
