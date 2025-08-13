import 'package:flutter/material.dart';

class GaleriCarouselGroup extends StatefulWidget {
  final List<String> imagePaths;

  const GaleriCarouselGroup({super.key, required this.imagePaths});

  @override
  State<GaleriCarouselGroup> createState() => _GaleriCarouselGroupState();
}

class _GaleriCarouselGroupState extends State<GaleriCarouselGroup> {
  late final PageController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.85);
    _controller.addListener(() {
      int next = _controller.page!.round();
      if (_currentIndex != next) {
        setState(() => _currentIndex = next);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: _currentIndex == index ? 10 : 6,
      height: _currentIndex == index ? 10 : 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.orange : Colors.grey[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.imagePaths.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    widget.imagePaths[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.imagePaths.length,
            (index) => buildIndicator(index),
          ),
        ),
      ],
    );
  }
}
