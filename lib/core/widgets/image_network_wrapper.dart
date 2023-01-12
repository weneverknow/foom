import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageNetworkWrapper extends StatelessWidget {
  const ImageNetworkWrapper({
    required this.imageUrl,
    super.key,
    this.height = double.infinity,
    this.width = double.infinity,
  });
  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: child,
        );
      },
      fit: BoxFit.cover,
      height: height,
      width: width,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
    );
  }
}
