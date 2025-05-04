import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  final String? posterUrl;
  final double aspectRatio;
  final BorderRadius borderRadius;

  const MoviePoster({
    super.key,
    this.posterUrl,
    required this.aspectRatio,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: posterUrl != null && posterUrl!.isNotEmpty
            ? Image.network(
                posterUrl!,
                fit: BoxFit.fill,
                errorBuilder: (_, __, ___) => _fallbackImage(),
              )
            : _fallbackImage(),
      ),
    );
  }

  Widget _fallbackImage() {
    return Image.asset(
      'assets/images/no_image_available.png',
      fit: BoxFit.fill,
    );
  }
}
