import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'dashboard.dart';
import 'profile_page.dart';
import 'about_page.dart';
import 'notification_page.dart';
import 'widget/CustomBottomNavBar.dart';
import 'widget/content_tentang.dart';
import 'widget/search_bar_widget.dart';  // Import search bar widget

class TentangPage extends StatefulWidget {
  const TentangPage({super.key});

  @override
  State<TentangPage> createState() => _TentangPageState();
}

class _TentangPageState extends State<TentangPage> {
  String userName = "Pengguna";
  final int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await AuthService.getName();
    setState(() {
      userName = name ?? "Pengguna";
    });
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
    // Misalnya, bisa kamu pakai untuk filter konten tentang jika perlu
    print("Search query: $query");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ Background
          Positioned.fill(
            child: Image.asset(
              'assets/background2.png',
              fit: BoxFit.cover,
            ),
          ),

          // ✅ Foreground
          Column(
            children: [
              // ✅ AppBar
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

              // ✅ Konten Scrollable dengan SearchBar
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12),
                        // const Text(
                        //   'Tentang Kami',
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.orange,
                        //   ),
                        // ),
                        // const SizedBox(height: 12),

                        // ** Widget SearchBar ditambahkan di sini **
                        SearchBarWidget(
                          onChanged: _onSearchChanged,
                        ),

                        const SizedBox(height: 20),

                        const ContentTentang(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),

              // ✅ Bottom Navigation
              CustomBottomNavBar(
                currentIndex: _selectedIndex,
                onTap: _onBottomNavTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
