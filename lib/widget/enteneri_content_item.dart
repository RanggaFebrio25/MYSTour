import 'package:flutter/material.dart';

class EnteneriContentItem extends StatelessWidget {
  final String dayTitle;
  final String location;
  final Widget icon; // Ubah tipe icon menjadi Widget
  final String description;
  final String flightInfo;
  final String mealInfo;

  const EnteneriContentItem({
    super.key,
    required this.dayTitle,
    required this.location,
    required this.icon,  // sekarang menerima Widget
    required this.description,
    required this.flightInfo,
    required this.mealInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: IntrinsicHeight( // Biar semua anak Row sama tinggi
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Agar tinggi anak Row maksimal
          children: [
            /// === KIRI: DAY + ICON ===
            Container(
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '$dayTitle\n',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.orange,
                      ),
                      children: [
                        TextSpan(
                          text: location,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: icon, // langsung pasang widget icon di sini
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            /// === TENGAH: DESKRIPSI ===
            Expanded(
              flex: 4,
              child: Text(
                description,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 13.5,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(width: 16),

            /// === KANAN: BOX INFO ===
            Container(
              width: 120,
              height: double.infinity, // agar tinggi mengikuti Row / IntrinsicHeight
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade600,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (flightInfo.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        flightInfo,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                  if (mealInfo.isNotEmpty)
                    Text(
                      mealInfo,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
