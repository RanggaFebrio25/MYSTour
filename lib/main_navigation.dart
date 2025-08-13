import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';
import 'notification_page.dart';
import 'about_page.dart';
import 'widget/CustomBottomNavBar.dart';

class MainNavigation extends StatefulWidget {
  final int selectedIndex;

  const MainNavigation({super.key, this.selectedIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _selectedIndex;

  final List<Widget> _pages = const [
    DashboardPage(),
    ProfilePage(),
    NotificationPage(),
    AboutPage(),
  ];

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  void _onTap(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavBar(
              currentIndex: _selectedIndex,
              onTap: _onTap,
            ),
          ),
        ],
      ),
    );
  }
}
