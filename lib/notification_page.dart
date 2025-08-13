import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'profile_page.dart';
import 'dashboard.dart';
import 'about_page.dart';
import 'widget/sholat_alarm_widget.dart';
import 'widget/qibla_compass_widget.dart';
import 'widget/CustomBottomNavBar.dart';
import 'widget/search_bar_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _selectedIndex = 2;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onBottomNavTap(int index) {
    if (index == _selectedIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const DashboardPage()));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const ProfilePage()));
    } else if (index == 3) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const AboutPage()));
    }
  }

  void _onSearchChanged(String query) {
    print("Search query: $query");
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                child: Image.asset('assets/background2.png', fit: BoxFit.cover),
              ),
              Column(
                children: [
                  // AppBar custom
                  Material(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 36, left: 16, right: 16, bottom: 12),
                      color: Colors.white,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.orange),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Image.asset('assets/logo2.png',
                              width: 52, height: 52),
                          const Spacer(),
                          const Icon(Icons.person, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(userName,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.orange)),
                        ],
                      ),
                    ),
                  ),

                  // Kontainer putih full dari bawah AppBar
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        children: [
                          // Gambar + SearchBar di dalam container putih
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(30),
                                ),
                                child: Image.asset(
                                  'assets/bg-sholat.png',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 150,
                                ),
                              ),
                              Positioned(
                                left: 16,
                                right: 16,
                                bottom: 45,
                                child: SearchBarWidget(
                                  onChanged: _onSearchChanged,
                                ),
                              ),
                            ],
                          ),

                          // Isi PageView
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: PageView(
                                      controller: _pageController,
                                      onPageChanged: (index) {
                                        setState(() {
                                          _currentPage = index;
                                        });
                                      },
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 20),
                                            const Text(
                                              "Jadwal Sholat",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange),
                                            ),
                                            const SizedBox(height: 16),
                                            const Expanded(
                                                child: SholatAlarmWidget()),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 20),
                                            const Text(
                                              "Arah Kiblat",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange),
                                            ),
                                            const SizedBox(height: 16),
                                            const Expanded(
                                                child: QiblaCompassWidget()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Indikator
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(2, (index) {
                                      return AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        width: _currentPage == index ? 12 : 8,
                                        height: _currentPage == index ? 12 : 8,
                                        decoration: BoxDecoration(
                                          color: _currentPage == index
                                              ? Colors.orange
                                              : Colors.grey[400],
                                          shape: BoxShape.circle,
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom NavBar
                  CustomBottomNavBar(
                    currentIndex: _selectedIndex,
                    onTap: _onBottomNavTap,
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
