import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_planner/src/core/base/base_widget_mixin.dart';

class AssetImageView extends StatelessWidget with BaseWidgetMixin {
  AssetImageView({
    super.key,
    required this.fileName,
    this.height,
    this.width,
    this.color,
    this.scale,
    this.fit,
  });

  final String fileName;
  final double? height;
  final double? width;
  final Color? color;
  final double? scale;
  final BoxFit? fit;

  @override
  Widget body(BuildContext context) {
    String mimType = fileName.split(".").last;
    String path = "assets/images/$fileName";

    if (mimType.isEmpty) {
      return Icon(Icons.image_not_supported_outlined, size: width, color: color);
    }

    switch (mimType) {
      case "svg":
        return SvgPicture.asset(
          path,
          height: height,
          width: width,
          colorFilter: color == null
              ? null
              : ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
          fit: fit ?? BoxFit.contain,
        );
      case "png":
      case "jpg":
      case "jpeg":
        return Image.asset(
          path,
          height: height,
          width: width,
          color: color,
          scale: scale,
          fit: fit,
        );
      default:
        return Icon(Icons.image_not_supported_outlined, size: width, color: color);
    }
  }
}
