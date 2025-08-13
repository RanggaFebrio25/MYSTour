import 'package:flutter/material.dart';

class CourseManagementCarousel extends StatefulWidget {
  const CourseManagementCarousel({super.key});

  @override
  State<CourseManagementCarousel> createState() => _CourseManagementCarouselState();
}

class _CourseManagementCarouselState extends State<CourseManagementCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.85);
  final List<String> imagePaths = List.generate(
    10,
    (index) => 'assets/profile${index + 1}.png',
  );

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 500,
            child: PageView.builder(
              controller: _controller,
              itemCount: imagePaths.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Image.asset(
                        imagePaths[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imagePaths.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: _currentIndex == index ? 12 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.orange : Colors.grey.shade300,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
