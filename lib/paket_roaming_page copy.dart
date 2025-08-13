import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'dashboard.dart';
import 'profile_page.dart';
import 'about_page.dart';
import 'notification_page.dart';
import 'widget/roaming_widget.dart';

import 'widget/CustomBottomNavBar.dart';

class PaketRoamingPage extends StatefulWidget {
  const PaketRoamingPage({super.key});

  @override
  State<PaketRoamingPage> createState() => _PaketRoamingPageState();
}

class _PaketRoamingPageState extends State<PaketRoamingPage> {
  final  int _selectedIndex = 2;

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
  } else if (index == 4) {
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
                child: Image.asset('assets/background2.png', fit: BoxFit.cover),
              ),
              Column(
                children: [
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

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: const SingleChildScrollView(
                        child: RoamingWidget(),
                      ),
                    ),
                  ),

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
