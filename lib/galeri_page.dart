import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'dashboard.dart';
import 'profile_page.dart';
import 'about_page.dart';
import 'notification_page.dart';
import 'widget/CustomBottomNavBar.dart';
import 'widget/galeri_carousel_group.dart';
import 'widget/search_bar_widget.dart'; // pastikan ini ada

class GaleriPage extends StatefulWidget {
  const GaleriPage({super.key});

  @override
  State<GaleriPage> createState() => _GaleriPageState();
}

class _GaleriPageState extends State<GaleriPage> {
  final int _selectedIndex = 0;

  // Semua grup galeri asli
  final List<List<String>> allGroupedImages = [
    ['assets/galeri1a.png', 'assets/galeri1b.png', 'assets/galeri1c.png'],
    ['assets/galeri2a.png', 'assets/galeri2b.png', 'assets/galeri2c.png'],
    ['assets/galeri3a.png', 'assets/galeri3b.png', 'assets/galeri3c.png'],
    ['assets/galeri4a.png', 'assets/galeri4b.png', 'assets/galeri4c.png'],
    ['assets/galeri5a.png', 'assets/galeri5b.png', 'assets/galeri5c.png'],
    ['assets/galeri6a.png', 'assets/galeri6b.png', 'assets/galeri6c.png'],
  ];

  // Grup galeri yang sudah difilter (awal = semua)
  late List<List<String>> filteredGroupedImages;

  @override
  void initState() {
    super.initState();
    filteredGroupedImages = allGroupedImages;
  }

  void _onBottomNavTap(int index) {
    if (index == _selectedIndex) return;

    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const DashboardPage()));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationPage()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()));
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredGroupedImages = allGroupedImages;
      } else {
        // Filter grup yang memiliki minimal satu gambar yang mengandung query (case insensitive)
        filteredGroupedImages = allGroupedImages.where((group) {
          return group.any((imgPath) => imgPath.toLowerCase().contains(query.toLowerCase()));
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AuthService.getName(),
      builder: (context, snapshot) {
        final userName = snapshot.data ?? "Pengguna";

        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/background2.png',
                  fit: BoxFit.cover,
                ),
              ),

              Column(
                children: [
                  // Custom AppBar
                  Material(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: Container(
                      padding: const EdgeInsets.only(top: 36, left: 16, right: 16, bottom: 12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios, color: Colors.orange),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Image.asset('assets/logo2.png', width: 52, height: 52),
                          const Spacer(),
                          const Icon(Icons.person, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(
                            userName,
                            style: const TextStyle(fontSize: 14, color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Search Bar dan Konten Galeri
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          SearchBarWidget(
                            onChanged: _onSearchChanged,
                          ),
                          const SizedBox(height: 16),

                          Expanded(
                            child: filteredGroupedImages.isEmpty
                                ? const Center(child: Text('Tidak ada galeri ditemukan.'))
                                : ListView.builder(
                                    itemCount: filteredGroupedImages.length,
                                    itemBuilder: (context, index) {
                                      final group = filteredGroupedImages[index];
                                      return Column(
                                        children: [
                                          GaleriCarouselGroup(imagePaths: group),
                                          const SizedBox(height: 20),
                                        ],
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom NavBar
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CustomBottomNavBar(
                      currentIndex: _selectedIndex,
                      onTap: _onBottomNavTap,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
