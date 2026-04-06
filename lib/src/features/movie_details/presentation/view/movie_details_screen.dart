import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/src/core/base/base_view.dart';
import 'package:movie_planner/src/core/constants/app_values.dart';
import 'package:movie_planner/src/core/utils/application_bar.dart';
import 'package:movie_planner/src/core/utils/network_image_view.dart';
import 'package:movie_planner/src/features/movie_details/presentation/bloc/movie_details_bloc.dart';

class MovieDetailsScreen extends BaseView<MovieDetailsBloc, MovieDetailsState> {
  final int movieId;
  final String? movieTitle;

  MovieDetailsScreen({super.key, required this.movieId, this.movieTitle});

  @override
  bool isLoading(MovieDetailsState state) => state.isLoading;

  @override
  String errorMessage(MovieDetailsState state) => state.error ?? "";

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return ApplicationBar(appTitleText: movieTitle ?? "Movie Details");
  }

  @override
  Widget body(BuildContext context) {
    final state = context.watch<MovieDetailsBloc>().state;
    final details = state.details;

    if (details == null) {
      return const Center(child: Text("Loading movie details..."));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppValues.gap),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppValues.radiusMedium),
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: details.posterPath.isNotEmpty
                    ? NetworkImageView(
                        imgUrl: "https://image.tmdb.org/t/p/w780${details.posterPath}",
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.movie, size: 64, color: Colors.grey),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: AppValues.gap),
            Text(
              details.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppValues.gapSmall),
            Row(
              children: [
                const Icon(Icons.calendar_month, size: 16),
                const SizedBox(width: 6),
                Text(details.releaseDate.isEmpty ? "Unknown" : details.releaseDate),
                const SizedBox(width: 16),
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 6),
                Text(details.rating.toStringAsFixed(1)),
              ],
            ),
            const SizedBox(height: AppValues.gap),
            Text(
              "Overview",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppValues.gapSmall),
            Text(
              details.overview.isEmpty ? "No overview available." : details.overview,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
