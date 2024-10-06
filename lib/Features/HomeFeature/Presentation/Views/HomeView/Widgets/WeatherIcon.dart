import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: 70,
      width: 70,
      fit: BoxFit.fill,
      progressIndicatorBuilder: (context, url, progress) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      },
      errorWidget: (context, url, error) {
        return const Placeholder();
      },
    );
  }
}
