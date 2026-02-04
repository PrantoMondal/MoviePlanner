import 'package:flutter/material.dart';
import 'package:movie_planner/src/core/constants/app_values.dart';
import 'package:movie_planner/src/core/utils/network_image_view.dart';
import 'package:movie_planner/src/features/home/domain/entities/movie_entity.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;
  final VoidCallback? onTap;

  const MovieCard({super.key, required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: AppValues.gapSmall),
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppValues.radiusMedium),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppValues.radiusMedium),
              ),
              child: Container(
                height: 170,
                width: double.infinity,
                color: Colors.grey[300],
                child: movie.posterPath.isNotEmpty
                    ? NetworkImageView(
                        imgUrl: "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                      )
                    : _buildPlaceholder(),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppValues.gapSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Text(
                        movie.title,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: AppValues.gapSmall),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Center(child: Icon(Icons.movie, size: 48, color: Colors.grey)),
    );
  }
}
