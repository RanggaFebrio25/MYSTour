import 'package:flutter/material.dart';

class GaleriCarousel extends StatelessWidget {
  final List<String> imagePaths;

  const GaleriCarousel({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(viewportFraction: 0.85),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imagePaths[index],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        );
      },
    );
  }
}
