import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/injection_container.dart';
import 'package:movie_planner/src/features/movie_details/presentation/bloc/movie_details_bloc.dart';
import 'package:movie_planner/src/features/movie_details/presentation/view/movie_details_screen.dart';

class Routes {
  static const dashboard = 'dashboard';
  static const splash = 'splash';
  static const home = '/';
  static const history = '/history';
  static const movieDetails = '/movie-details';
}

class MovieDetailsArgs {
  final int movieId;
  final String? movieTitle;

  const MovieDetailsArgs({required this.movieId, this.movieTitle});
}

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.movieDetails:
        final args = settings.arguments as MovieDetailsArgs;
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => BlocProvider<MovieDetailsBloc>(
            create: (_) =>
                sl<MovieDetailsBloc>()..add(FetchMovieDetails(movieId: args.movieId)),
            child: MovieDetailsScreen(
              movieId: args.movieId,
              movieTitle: args.movieTitle,
            ),
          ),
        );
      default:
        return null;
    }
  }
}
