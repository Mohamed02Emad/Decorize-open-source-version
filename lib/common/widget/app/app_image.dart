import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String? path;
  final File? file;
  final double height;
  final double width;
  final double radius;
  final BoxFit fit;
  final Color? color;

  const AppImage({
    super.key,
    required this.path,
    this.file,
    this.height = 100,
    this.color,
    this.width = 100,
    this.radius = 0,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (file != null) {
      return Image.file(
        file!,
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return _errorWidget();
        },
      ).clip(radius);
    } else {
      return Image.asset(
        path ?? '',
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return CachedNetworkImage(
            imageUrl: path ?? '',
            height: height,
            width: width,
            fit: fit,
            color: color,
            progressIndicatorBuilder: (context, url, downloadProgress) {
              if (downloadProgress.progress == 1.0) {
                return _fadeEffect(Image.network(
                  url,
                  height: height,
                  width: width,
                  fit: fit,
                  color: color,
                ));
              }
              return Skeleton(
                height: height,
                width: width,
              );
            },
            errorWidget: (context, url, error) {
              try {
                return _fadeEffect(SvgPicture.asset(
                  path ?? '',
                  height: height,
                  width: width,
                  fit: fit,
                  colorFilter: color?.colorFilter,
                ));
              } catch (e) {
                return _errorWidget();
              }
            },
          );
        },
      ).clip(radius);
    }
  }

  Widget _fadeEffect(Widget child) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      child: child,
    );
  }

  Widget _errorWidget() {
    return Icon(
      Icons.image_not_supported,
      size: height,
      color: color,
    );
  }
}
