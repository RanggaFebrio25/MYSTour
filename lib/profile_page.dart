import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'widget/CustomBottomNavBar.dart';
import 'widget/profile_form_widget.dart';
import 'widget/search_bar_widget.dart';  // pastikan import ini
import 'dashboard.dart';
import 'notification_page.dart';
import 'about_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int _selectedIndex = 1;

  void _onBottomNavTap(int index) {
    if (index == _selectedIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
    } else if (index == 1) {
      // Sudah di halaman ini
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NotificationPage()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AboutPage()),
      );
    }
  }

  void _onSearchChanged(String query) {
    // Proses input pencarian di sini
    print("Search query: $query");
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
              // Background
              Positioned.fill(
                child: Image.asset('assets/background2.png', fit: BoxFit.cover),
              ),

              // Foreground
              Column(
                children: [
                  // AppBar dengan radius bawah
                  Material(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 36, left: 16, right: 16, bottom: 12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(30)),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon:
                                const Icon(Icons.arrow_back_ios, color: Colors.orange),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Image.asset('assets/logo2.png', width: 52, height: 52),
                          const Spacer(),
                          const Icon(Icons.person, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(userName,
                              style:
                                  const TextStyle(fontSize: 14, color: Colors.orange)),
                        ],
                      ),
                    ),
                  ),

                  // Container putih dengan Search Bar di atas ProfileFormWidget
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(30)),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tambah SearchBarWidget di sini
                            SearchBarWidget(
                              onChanged: _onSearchChanged,
                            ),
                            const SizedBox(height: 20),

                            // Konten form profile asli
                            const ProfileFormWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom Navigation Bar
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
