import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/src/core/base/base_view.dart';
import 'package:movie_planner/src/core/routes/app_router.dart';
import 'package:movie_planner/src/core/theme/theme_cubit.dart';
import 'package:movie_planner/src/core/utils/application_bar.dart';
import 'package:movie_planner/src/core/utils/horizontal_paging_section.dart';
import 'package:movie_planner/src/features/home/domain/entities/movie_entity.dart';
import 'package:movie_planner/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_planner/src/features/home/presentation/widgets/movie_card.dart';

class HomeScreen extends BaseView<HomeBloc, HomeState> {
  HomeScreen({super.key});

  final ScrollController _popularScroll = ScrollController();
  final ScrollController _topRatedScroll = ScrollController();
  final ScrollController _upcomingScroll = ScrollController();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return ApplicationBar(
      appTitleText: 'Movie Planner',
      actions: [
        IconButton(
          icon: Icon(
            context.watch<ThemeCubit>().state == AppThemeMode.dark
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
          ),
          onPressed: () {
            context.read<ThemeCubit>().toggleTheme();
          },
        ),
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final homeBloc = context.read<HomeBloc>();

        return SingleChildScrollView(
          child: Column(
            children: [
              HorizontalPagingSection<MovieEntity>(
                title: "Popular Movies",
                scrollController: _popularScroll,
                pagingBloc: homeBloc.popularPagingBloc,
                loadData: () => homeBloc.add(const FetchMovies(category: "popular")),
                itemBuilder: (context, index, movie) =>
                    _popularMovieItemBuilder(context, index, movie),
              ),

              HorizontalPagingSection<MovieEntity>(
                title: "Top Rated Movies",
                scrollController: _topRatedScroll,
                pagingBloc: homeBloc.topRatedPagingBloc,
                loadData: () => homeBloc.add(const FetchMovies(category: "top_rated")),
                itemBuilder: (context, index, movie) =>
                    _movieItemBuilder(context, index, movie),
              ),

              HorizontalPagingSection<MovieEntity>(
                title: "Upcoming Movies",
                scrollController: _upcomingScroll,
                pagingBloc: homeBloc.upcomingPagingBloc,
                loadData: () => homeBloc.add(const FetchMovies(category: "upcoming")),
                itemBuilder: (context, index, movie) =>
                    _movieItemBuilder(context, index, movie),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _movieItemBuilder(BuildContext context, int index, MovieEntity movie) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.movieDetails,
          arguments: MovieDetailsArgs(movieId: movie.id, movieTitle: movie.title),
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: movie.posterPath.isNotEmpty
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      width: 140,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 140,
                          height: 180,
                          color: Colors.grey[300],
                          child: const Icon(Icons.movie, size: 48),
                        );
                      },
                    )
                  : Container(
                      width: 140,
                      height: 180,
                      color: Colors.grey[300],
                      child: const Icon(Icons.movie, size: 48),
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _popularMovieItemBuilder(BuildContext context, int index, MovieEntity movie) {
    return MovieCard(
      movie: movie,
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.movieDetails,
          arguments: MovieDetailsArgs(movieId: movie.id, movieTitle: movie.title),
        );
      },
    );
  }
}
