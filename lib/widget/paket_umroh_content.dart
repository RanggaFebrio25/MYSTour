import 'package:flutter/material.dart';

class PaketUmrohContent extends StatelessWidget {
  final List<String> imagePaths = const [
    'assets/paketumroh.png',
    // Tambahkan gambar lain jika diperlukan
  ];

  const PaketUmrohContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil tinggi layar dan sisihkan bagian untuk AppBar dan BottomNav
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight * 0.5; // Gunakan 50% dari tinggi layar

    return SizedBox(
      height: availableHeight,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.85),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          final image = imagePaths[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }
}
