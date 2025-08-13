import 'package:flutter/material.dart';
import 'dart:async';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.95);

  final List<String> _bannerImages = [
    'assets/banner1.png',
    'assets/banner2.png',
    'assets/banner3.png',
  ];

  @override
  void initState() {
    super.initState();
    // Auto Slide
    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentIndex + 1) % _bannerImages.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 230, // Naikkan tinggi agar banner lebih besar
          child: PageView.builder(
            controller: _pageController,
            itemCount: _bannerImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // margin dikurangi supaya banner lebih lebar
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // radius semua sudut bulat
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    _bannerImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _bannerImages.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 6),
              width: _currentIndex == index ? 14 : 10,
              height: _currentIndex == index ? 14 : 10,
              decoration: BoxDecoration(
                color: _currentIndex == index ? Colors.orange : Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
