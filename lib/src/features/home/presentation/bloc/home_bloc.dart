import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/src/core/base/base_event.dart';
import 'package:movie_planner/src/core/base/base_state.dart';
import 'package:movie_planner/src/core/paging/paging_bloc.dart';
import 'package:movie_planner/src/core/paging/paging_event.dart';
import 'package:movie_planner/src/features/home/domain/entities/movie_entity.dart';
import 'package:movie_planner/src/features/home/domain/usecases/get_movies_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMoviesUseCase getMoviesUseCase;

  final PagingBloc<MovieEntity> popularPagingBloc;
  final PagingBloc<MovieEntity> topRatedPagingBloc;
  final PagingBloc<MovieEntity> upcomingPagingBloc;

  HomeBloc(this.getMoviesUseCase)
    : popularPagingBloc = PagingBloc<MovieEntity>(),
      topRatedPagingBloc = PagingBloc<MovieEntity>(),
      upcomingPagingBloc = PagingBloc<MovieEntity>(),
      super(const HomeState()) {
    on<FetchMovies>(_onFetchMovies);
    on<RefreshMovies>(_onRefreshMovies);
  }

  Future<void> _onFetchMovies(FetchMovies event, Emitter<HomeState> emit) async {
    final bloc = _getPagingBloc(event.category);

    if (!bloc.canLoadNextPage()) return;

    try {
      final movieList = await getMoviesUseCase(
        category: event.category,
        page: bloc.state.pageNumber,
      );

      // Important: Use the results directly, they're already List<MovieEntity>
      final List<MovieEntity> movies = movieList.results;

      if (bloc.state.pageNumber >= movieList.totalPages) {
        bloc.add(PagingLoadLastPage<MovieEntity>(items: movies));
      } else {
        bloc.add(PagingLoadNextPage<MovieEntity>(items: movies));
      }
    } catch (e) {
      bloc.add(PagingError<MovieEntity>(message: e.toString()));
    }
  }

  Future<void> _onRefreshMovies(RefreshMovies event, Emitter<HomeState> emit) async {
    final bloc = _getPagingBloc(event.category);

    bloc.add(const PagingRefresh<MovieEntity>());

    try {
      final movieList = await getMoviesUseCase(category: event.category, page: 1);

      final List<MovieEntity> movies = movieList.results;

      if (movies.isEmpty) {
        bloc.add(PagingLoadLastPage<MovieEntity>(items: <MovieEntity>[]));
      } else {
        bloc.add(PagingLoadNextPage<MovieEntity>(items: movies));
      }
    } catch (e) {
      bloc.add(PagingError<MovieEntity>(message: e.toString()));
    }
  }

  PagingBloc<MovieEntity> _getPagingBloc(String category) {
    switch (category) {
      case 'popular':
        return popularPagingBloc;
      case 'top_rated':
        return topRatedPagingBloc;
      case 'upcoming':
        return upcomingPagingBloc;
      default:
        return popularPagingBloc;
    }
  }

  @override
  Future<void> close() {
    popularPagingBloc.close();
    topRatedPagingBloc.close();
    upcomingPagingBloc.close();
    return super.close();
  }
}
