import 'package:flutter/material.dart';
import 'package:movie_planner/src/core/base/base_widget_mixin.dart';
import 'package:movie_planner/src/core/constants/app_values.dart';
import 'package:movie_planner/src/core/utils/extensions.dart';

class NetworkImageView extends StatelessWidget with BaseWidgetMixin {
  NetworkImageView({
    super.key,
    required this.imgUrl,
    this.boxDecoration,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
  });

  final String imgUrl;
  final double? height;
  final double? width;
  final BoxDecoration? boxDecoration;
  final BoxFit fit;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget body(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        decoration: boxDecoration ?? BoxDecoration(),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          imgUrl,
          height: height,
          width: width,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: AppValues.icon_38,
                  color: context.colors.error,
                ),
              ),
            );
          },
          loadingBuilder:
              (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Container(
                    alignment: Alignment.center,
                    height: height,
                    width: width,
                    child: CircularProgressIndicator(
                      color: context.colors.outlineVariant,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
        ),
      ),
    );
  }
}
