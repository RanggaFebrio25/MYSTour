import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TentangContentWidget extends StatelessWidget {
  const TentangContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> carouselItems = [
      {
        "image": "assets/banner1.png",
        "text": "Layanan Umroh terpercaya dan profesional."
      },
      {
        "image": "assets/banner2.png",
        "text": "Nikmati perjalanan spiritual yang nyaman."
      },
      {
        "image": "assets/banner3.png",
        "text": "Didampingi oleh pembimbing berpengalaman."
      },
      {
        "image": "assets/banner4.png",
        "text": "Beragam paket Haji Plus dan wisata Islami."
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        CarouselSlider.builder(
          itemCount: carouselItems.length,
          itemBuilder: (context, index, realIndex) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    carouselItems[index]['image']!,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  carouselItems[index]['text']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            height: 250,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            enableInfiniteScroll: true,
          ),
        ),
      ],
    );
  }
}
