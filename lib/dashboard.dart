import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'about_page.dart';
import 'notification_page.dart';
import 'widget/banner_carousel.dart';
import 'widget/TwoBannerWidget.dart';
import 'widget/MenuGridWidget.dart';
import 'widget/CustomBottomNavBar.dart';
import 'widget/search_bar_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void _onBottomNavTap(int index) async {
    if (index == 0) { 
      setState(() {
        _selectedIndex = 0; // Home tetap di dashboard
      });
    } else if (index == 1) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProfilePage()),
      );
    } else if (index == 2) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const NotificationPage()),
      );
    } else if (index == 3) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AboutPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AuthService.getName(),
      builder: (context, snapshot) {
        final String userName = snapshot.data ?? "Pengguna";

        return Scaffold(
          body: Stack(
            children: [
              // Background
              Positioned.fill(
                child: Image.asset(
                  'assets/background.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Foreground
              Column(
                children: [
                  _buildAppBar(userName),

                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SearchBarWidget(
                      onChanged: (value) {
                        print('Search query: $value');
                        // Bisa panggil fungsi filter data di sini
                      },
                    ),
                  ),

                  Expanded(child: _buildDashboardContent()),
                ],
              ),

              // Custom Bottom Nav
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
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

  Widget _buildAppBar(String userName) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset('assets/logo2.png', width: 52, height: 52),
          const Spacer(),
          const Icon(Icons.person, color: Colors.orange),
          const SizedBox(width: 8),
          Text(
            userName,
            style: const TextStyle(fontSize: 16, color: Colors.orange),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.orange),
            onPressed: () async {
              await AuthService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: const [
              SizedBox(height: 16),
              BannerCarousel(),
              SizedBox(height: 10),
              TwoBannerWidget(),
              SizedBox(height: 10),
              MenuGridWidget(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
