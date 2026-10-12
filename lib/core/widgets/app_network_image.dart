import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage(this.url, {super.key, this.fit = BoxFit.contain, this.cacheWidth, this.height, this.width});
  final String url;
  final BoxFit fit;
  final int? cacheWidth;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height:height ,
      width: width,
      imageUrl: url,
      fit: fit,
      memCacheWidth: cacheWidth, // بيفك الصورة بحجم صغير في الرام
      fadeInDuration: const Duration(milliseconds: 150),
      placeholder: (_, _) => const CupertinoActivityIndicator(color: Colors.indigo, radius: 8),
      errorWidget: (_, _, _) =>
          const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
    );
  }
}
