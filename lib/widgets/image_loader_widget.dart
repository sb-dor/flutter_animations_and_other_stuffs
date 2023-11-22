import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:shimmer/shimmer.dart';

class ImageLoaderWidget extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final EdgeInsets? marginShimmerContainer;
  final EdgeInsets? paddingShimmerContainer;
  final String errorImageUrl;
  final BorderRadius? borderRadius;
  final String? hashedImage;
  final Duration? duration;

  const ImageLoaderWidget({
    Key? key,
    required this.url,
    required this.errorImageUrl,
    this.height,
    this.width,
    this.boxFit,
    this.marginShimmerContainer,
    this.paddingShimmerContainer,
    this.borderRadius,
    this.hashedImage,
    this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        width: width,
        httpHeaders: const {
          "Accept": "application/json",
          "Connection": "Keep-Alive",
          "Keep-Alive": "timeout=10, max=1000"
        },
        fit: boxFit ?? BoxFit.scaleDown,
        placeholder: (context, url) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            period: duration ?? const Duration(milliseconds: 1500),
            child: Container(
                margin: marginShimmerContainer,
                padding: paddingShimmerContainer,
                width: width,
                height: height,
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: borderRadius)),
          );
        },
        errorWidget: (context, url, error) =>
            Image.asset(errorImageUrl, height: height, width: width, fit: BoxFit.scaleDown));
  }
}
