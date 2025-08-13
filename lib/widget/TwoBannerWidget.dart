import 'package:flutter/material.dart';

class TwoBannerWidget extends StatelessWidget {
  const TwoBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Expanded(child: _buildBannerItem('assets/banner4.png')),
          const SizedBox(width: 10), // jarak antar banner
          Expanded(child: _buildBannerItem('assets/banner5.png')),
        ],
      ),
    );
  }

  Widget _buildBannerItem(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
