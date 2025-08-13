import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'dashboard.dart';
import 'profile_page.dart';
import 'about_page.dart';
import 'notification_page.dart';
import 'widget/CustomBottomNavBar.dart';
import 'widget/CourseManagementCarousel.dart';
import 'widget/search_bar_widget.dart';  // Import widget search

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  final int _selectedIndex = 0;

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
    // Fungsi jika ingin memproses input pencarian
    print("Search query: $query");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AuthService.getName(),
      builder: (context, snapshot) {
        final userName = snapshot.data ?? "Pengguna";

        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
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
                      const SizedBox(width: 8),

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

              // Tambahkan SearchBar widget di sini
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SearchBarWidget(
                  onChanged: _onSearchChanged,
                ),
              ),

              // Carousel utama
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CourseManagementCarousel(),
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
        );
      },
    );
  }
}
