import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'profile_page.dart';
import 'dashboard.dart';
import 'notification_page.dart';
import 'widget/CustomBottomNavBar.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final  int _selectedIndex = 3;

  void _onBottomNavTap(int index) {
  if (index == _selectedIndex) return;

  if (index == 0) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const DashboardPage()));
  } else if (index == 1) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
  } else if (index == 2) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationPage()));
  } else if (index == 3) {
    // Sudah di halaman ini, tidak perlu pindah
  }
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
                  // ✅ Header
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
                          Text(userName, style: const TextStyle(fontSize: 14, color: Colors.orange)),
                        ],
                      ),
                    ),
                  ),

                  // ✅ Isi Konten
                  Expanded(
  child: Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
    child: SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 240,
                  maxHeight: 240,
                ),
                child: Image.asset(
                  'assets/logo2.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "MYSTOUR Hak Cipta Terlindungi",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Untuk Informasi Lebih Lanjut,\n"
                "Kunjungi https://www.MysTour.com\n"
                "atau hubungi kami di +62 823 2332 2015",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const Text(
                "Copyright © 2025 - MYSTOUR",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  ),
),


                  // ✅ Bottom Navbar
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
