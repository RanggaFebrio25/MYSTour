import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentTentang extends StatefulWidget {
  const ContentTentang({super.key});

  @override
  State<ContentTentang> createState() => _ContentTentangState();
}

class _ContentTentangState extends State<ContentTentang> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentIndex = 0;

  final List<Map<String, dynamic>> carouselItems = [
    {
      'image': 'assets/banner6.png',
      'title': 'Tentang MYSTOUR',
      'description': '''MYS TOUR sangat mengutamakan pelayanan dengan berbagai alternatif untuk mendukung kebutuhan pelanggan disetiap waktu, yaitu dengan tersedianya nomor Emergency 24 Jam. Sebagai Travel & Tour, kami akan memberikan kontribusi Sumber Daya Manusia dan Teknologi Informasi untuk meningkatkan efisiensi dalam proses Pelayanan Jamaah kami. Saat ini MYSTOUR mempunyai Kurang Lebih 65 Agen yang berpengalaman dibidangnya. MYSTOUR mendedikasikan untuk berkomitmen secara berkelanjutan untuk terus meningkatkan pelayanan dengan memberikan service terbaik kepada Jamaah.

PT. MUHAMAD YUNUS SUKSES atau lebih dikenal dengan MYSTOUR adalah merupakan salah satu Travel Agent modern yang berdiri sejak tahun 2015. Sebagai perusahaan yang bergerak dalam bidang Tour & Travel Management selama lebih dari 10 tahun.'''
    },
    {
      'image': 'assets/banner7.png',
      'title': 'Alamat MYSTOUR',
      'description':
          'Kota Padang tepatnya di Jl. Adinegoro Km 17 No. 15, Kel. Lubuk Buaya, Kec. Koto Tangah.\nPerusahaan ini sudah ada sejak tahun 2015 dan juga berizin resmi dari Kemenag sebagai perusahaan Tour Travel, Umroh & Haji.',
      'link': 'https://maps.app.goo.gl/em4vzjPKEq8ew18n6?g_st=awb',
    },
    {
      'image': 'assets/banner8.png',
      'title': 'Visi MYSTOUR',
      'description':
          'Menjadi Travel Agent yang kuat dan unggul dalam penyediaan, pendistribusian, penjualan, dan pemasaran produk Umroh dan Haji khusus. Secara B2B (Business to Business) maupun B2C (Business to Customer).',
    },
    {
      'image': 'assets/banner9.png',
      'title': 'Misi MYSTOUR',
      'misiList': [
        'Memberikan pelayanan terbaik dalam perjalanan ibadah Umroh dengan kenyamanan dan keamanan maksimal.',
        'Menyediakan bimbingan ibadah yang berkualitas sesuai dengan tuntunan syariah.',
        'Menjalin kerja sama dengan mitra terpercaya untuk memastikan fasilitas terbaik bagi jamaah.',
        'Menjaga profesionalisme dan integritas dalam setiap aspek operasional.',
        'Meningkatkan kepuasan jamaah dengan layanan yang ramah, amanah, dan transparan.',
      ],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = carouselItems[_currentIndex];

    return Column(
      children: [
        const SizedBox(height: 16),

        // Carousel
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: carouselItems.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final item = carouselItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    item['image']!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        // Dot indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(carouselItems.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 12 : 8,
              height: _currentIndex == index ? 12 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.orange : Colors.grey,
              ),
            );
          }),
        ),

        const SizedBox(height: 16),

        // Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Title
              Text(
                currentItem['title'] ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 12),

              // Description (if available)
              if (currentItem['description'] != null)
                Text(
                  currentItem['description'],
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),

              // Google Maps Button (if link available)
              if (currentItem['link'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: GestureDetector(
                    onTap: () => _launchURL(currentItem['link']),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Lihat lokasi di Google Maps",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

              // Misi list with orange bullets and connecting lines
              if (currentItem['misiList'] != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate((currentItem['misiList'] as List).length, (index) {
                    final isLast = index == (currentItem['misiList'] as List).length - 1;
                    return IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bullet and line
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: Column(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                if (!isLast)
                                  Expanded(
                                    child: Container(
                                      width: 2,
                                      color: Colors.orange,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Misi text
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                (currentItem['misiList'] as List)[index],
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
            ],
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
