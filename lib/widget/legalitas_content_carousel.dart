import 'package:flutter/material.dart';

class LegalitasContentCarousel extends StatefulWidget {
  const LegalitasContentCarousel({super.key});

  @override
  State<LegalitasContentCarousel> createState() => _LegalitasContentCarouselState();
}

class _LegalitasContentCarouselState extends State<LegalitasContentCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _slides = [
    Center(
      child: Image.asset(
        'assets/legalitas1.png',
        width: 250,
        fit: BoxFit.contain,
      ),
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/legalitas2.png',
          width: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 12),
        Image.asset(
          'assets/legalitas3.png',
          width: 200,
          fit: BoxFit.contain,
        ),
      ],
    ),
    Center(
      child: Image.asset(
        'assets/legalitas4.png',
        width: 250,
        fit: BoxFit.contain,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      int nextPage = (_currentIndex + 1) % _slides.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      setState(() => _currentIndex = nextPage);
      _startAutoPlay();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    // Sisakan tinggi untuk AppBar dan BottomNavBar agar tidak overflow
    final double availableHeight = screenHeight * 0.65;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: availableHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _slides.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) => _slides[index],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_slides.length, (index) {
            return Container(
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
    );
  }
}
