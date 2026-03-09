import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class AppImageWidget extends StatelessWidget {
  const AppImageWidget({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
    this.imageRadius,
    this.repeatLottie = true,
  });

  final String? imageUrl;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;
  final double? imageRadius;
  final bool repeatLottie;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(imageRadius ?? 0),
          ),
        ),
      );
    }
    if (imageUrl!.isEmpty) {
      return _wrapRadius(
        const Icon(Icons.image_not_supported, color: Colors.grey),
      );
    }
    // SVG support
    if (imageUrl!.endsWith('.svg')) {
      final isNetwork = imageUrl!.startsWith('http');

      return _wrapRadius(
        isNetwork
            ? SvgPicture.network(
                imageUrl!,
                height: height,
                width: width,
                fit: fit,
                colorFilter: color != null
                    ? ColorFilter.mode(color!, BlendMode.srcIn)
                    : null,
                placeholderBuilder: (_) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: height,
                    width: width,
                    color: Colors.white,
                  ),
                ),
              )
            : SvgPicture.asset(
                imageUrl!,
                height: height,
                width: width,
                fit: fit,
                colorFilter: color != null
                    ? ColorFilter.mode(color!, BlendMode.srcIn)
                    : null,
              ),
      );
    }

    if (imageUrl!.endsWith(".json") || imageUrl!.endsWith(".lottie")) {
      final isNetwork = imageUrl!.startsWith("http");
      final isDotLottie = imageUrl!.endsWith('.lottie');
      final decoder = isDotLottie ? _dotLottieDecoder : null;

      return _wrapRadius(
        isNetwork
            ? Lottie.network(
                imageUrl!,
                decoder: decoder,
                height: height,
                width: width,
                repeat: repeatLottie,
              )
            : Lottie.asset(
                imageUrl!,
                decoder: decoder,
                height: height,
                width: width,
                repeat: repeatLottie,
              ),
      );
    }

    if (imageUrl!.startsWith("assets/")) {
      return _wrapRadius(
        Image.asset(
          imageUrl!,
          height: height,
          width: width,
          fit: fit,
          color: color,
        ),
      );
    }
    final file = File(imageUrl!);
    if (file.existsSync()) {
      return _wrapRadius(
        Image.file(file, height: height, width: width, fit: fit, color: color),
      );
    }

    return _wrapRadius(
      CachedNetworkImage(
        imageUrl: imageUrl!,
        height: height,
        width: width,
        fit: fit,

        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(imageRadius ?? 0),
            ),
          ),
        ),
        errorWidget: (context, error, stackTrace) => Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(imageRadius ?? 0),
          ),
          // child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _wrapRadius(Widget child) {
    return imageRadius != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(imageRadius!),
            child: child,
          )
        : child;
  }

  Future<LottieComposition?> _dotLottieDecoder(List<int> bytes) {
    return LottieComposition.decodeZip(
      bytes,
      filePicker: (files) {
        for (final file in files) {
          if (file.name.startsWith('animations/') &&
              file.name.endsWith('.json')) {
            return file;
          }
        }
        for (final file in files) {
          if (file.name.endsWith('.json')) {
            return file;
          }
        }
        return null;
      },
    );
  }
}
