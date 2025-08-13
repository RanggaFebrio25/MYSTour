import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'dashboard.dart';
import 'profile_page.dart';
import 'about_page.dart';
import 'notification_page.dart';
import 'widget/CustomBottomNavBar.dart';
import 'widget/enteneri_content_item.dart';
import 'widget/search_bar_widget.dart';

class EnteneriPage extends StatefulWidget {
  const EnteneriPage({super.key});

  @override
  State<EnteneriPage> createState() => _EnteneriPageState();
}

class _EnteneriPageState extends State<EnteneriPage> {
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
              Positioned.fill(
                child: Image.asset(
                  'assets/background2.png',
                  fit: BoxFit.cover,
                ),
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
                          Text(
                            userName,
                            style: const TextStyle(fontSize: 14, color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SearchBarWidget(
                      onChanged: _onSearchChanged,
                    ),
                  ),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: ListView(
                        children: [
                          const SizedBox(height: 12),
                          // ... semua EnteneriContentItem seperti kode kamu
                        ],
                      ),
                    ),
                  ),

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











import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'dashboard.dart';
import 'profile_page.dart';
import 'about_page.dart';
import 'notification_page.dart';
import 'widget/CustomBottomNavBar.dart';
import 'widget/enteneri_content_item.dart';
import 'widget/search_bar_widget.dart';

class EnteneriPage extends StatefulWidget {
  const EnteneriPage({super.key});

  @override
  State<EnteneriPage> createState() => _EnteneriPageState();
}

class _EnteneriPageState extends State<EnteneriPage> {
  final  int _selectedIndex = 0 ;

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
          body: Stack(
            children: [
              // ✅ Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/background2.png',
                  fit: BoxFit.cover,
                ),
              ),

              // ✅ Foreground Content
              Column(
                children: [
                  // ✅ Custom AppBar
                  Material(
  elevation: 4,
  shadowColor: Colors.black12,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SearchBarWidget(
          onChanged: _onSearchChanged,
        ),
      ),
    ],
  ),
),


                  // ✅ Konten Utama
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: ListView(
                        children:  [
                          SizedBox(height: 12),
      

                        EnteneriContentItem(
  dayTitle: 'DAY 1',
  location: 'PADANG - KUL - JED',
  icon: Image.asset('assets/icon1.png', width: 24, height: 24),
  description: 'Berkumpul di bandara internasional minangkabau, untuk melakukan penerbangan ke kuala lumpur (Malaysia). Jamaah melanjutkan perjalanan menuju Jeddah. Sampai di Bandara King Abdul Aziz Jeddah, jamaah langsung menuju hotel Madinah.',
  flightInfo: 'PDG - JED\nDEPART: 12:05\nARRIVE: 21:20',
  mealInfo: 'MAKAN\nDi Lounge di BIM',
),

EnteneriContentItem(
  dayTitle: 'DAY 2',
  location: 'MADINAH',
  icon: Image.asset('assets/icon2.png', width: 24, height: 24),
  description: 'Berziarah ke makam Rasulullah SAW & para sahabat, didampingi muthawif perempuan dan laki-laki. Melaksanakan sholat sunah dan berdoa di Raudhah, kemudian memperbanyak ibadah di Masjid Nabawi.',
  flightInfo: '',
  mealInfo: 'MAKAN\nPagi, Siang,\nMalam',
),
EnteneriContentItem(
  dayTitle: 'DAY 3',
  location: 'MADINAH',
  icon: Image.asset('assets/icon3.png', width: 24, height: 24),
  description: 'Setelah sarpan pagi persiapan untuk ziarah kota madinah (city tour) ziarah mengunjungi masjid quba, jabal uhud, dan kebun kurma. Setelah itu kembali ke hotel dan kembali memperbanyak ibadah di masjid nabawi.',
  flightInfo: '',
  mealInfo: 'MAKAN\nPagi, Siang,\nMalam',
),
EnteneriContentItem(
  dayTitle: 'DAY 4',
  location: 'MADINAH',
  icon: Image.asset('assets/icon3.png', width: 24, height: 24),
  description: 'Setelah sarapan pagi, mandi sunah ikhram dan persiapan untuk cek out hotel. Setelah sholat zuhur dan makan siang persiapan keberangkatan menuju ke makkah dan mengambil miqat di biir ali / masjid syajarah. Tiba di makkah, langsung ke hotel makkah untuk menyimpan barang -barang dan makan malam, kemudian.',
  flightInfo: '',
  mealInfo: 'MAKAN\nPagi, Siang,\nMalam',
),EnteneriContentItem(
  dayTitle: 'DAY 5',
  location: 'MADINAH',
  icon: Image.asset('assets/icon3.png', width: 24, height: 24),
  description: 'Memperbanyak ibadah di masjid nabawi (free program).',
  flightInfo: '',
  mealInfo: 'MAKAN\nPagi, Siang,\nMalam',
),EnteneriContentItem(
  dayTitle: 'DAY 6',
  location: 'MAKKAH',
  icon: Image.asset('assets/icon2.png', width: 24, height: 24),
  description: 'Setelah sarapan pagi, persiapan ziarah kota makkah. Ziarah mengunjungi padang arafah, jabal rahmah, muzdalifah, mina dan jabal tsur, kemudian berakhir jaronah (bagi yang akan melaksanakan umroh kedua silahkan untuk mengambil miqot kembali bagi yang tidak mengikuti umroh kedua memperbanyak ibadah).',
  flightInfo: '',
  mealInfo: 'MAKAN\nPagi, Siang,\nMalam',
),EnteneriContentItem(
  dayTitle: 'DAY 7',
  location: 'MAKKAH',
  icon: Image.asset('assets/icon3.png', width: 24, height: 24),
  description: 'Memperbanyak ibadah di masjidil haram dan melaksanakan sholat jumat. (free program).',
  flightInfo: '',
  mealInfo: 'MAKAN\nPagi, Siang,\nMalam',
),EnteneriContentItem(
  dayTitle: 'DAY 8',
  location: 'MAKKAH',
  icon: Image.asset('assets/icon3.png', width: 24, height: 24),
  description: 'Memperbanyak ibadah di masjidil haram.(free program).',
  flightInfo: '',
  mealInfo: 'MAKAN\nPagi, Siang,\nMalam',
),EnteneriContentItem(
  dayTitle: 'DAY 9',
  location: 'MAKKAH',
  icon: Image.asset('assets/icon3.png', width: 24, height: 24),
  description: 'Setelah sarapan pagi, persiapan ziarah kota makkah. Ziarah mengunjungi padang arafah, jabal rahmah, muzdalifah, mina dan jabal tsur, kemudian berakhir ja ronah (bagi yang akan melaksanakan umroh kedua silahkan untuk mengambil miqot kembali bagi yang tidak mengikuti umroh kedua memperbanyak ibadah).',
  flightInfo: '',
  mealInfo: 'MAKAN\nPagi, Siang,\nMalam',
),EnteneriContentItem(
  dayTitle: 'DAY 10',
  location: 'MAKKAH',
  icon: Image.asset('assets/icon3.png', width: 24, height: 24),
  description: 'Memperbanyak ibadah di masjidil haram dan tausyiah bersama muthawif. (free program).',
  flightInfo: '',
  mealInfo: 'MAKAN\nPagi, Siang,\nMalam',
),EnteneriContentItem(
  dayTitle: 'DAY 11',
  location: 'MAKKAH',
  icon: Image.asset('assets/icon1.png', width: 24, height: 24),
  description: 'Setelah thawaf wada persiapan untuk cek out hotel. Jamaah bertolak menuju Jeddah dan city tour, mengunjungi cornice dan langsung menuju ke Bandar udara internasional king abdul aziz Jeddah.',
  flightInfo: '',
  mealInfo: 'JED - KUL, DEPART : 23:50 ,\nARRIVE : 14:30',
),EnteneriContentItem(
  dayTitle: 'DAY 12',
  location: 'MAKKAH',
  icon: Image.asset('assets/icon1.png', width: 24, height: 24),
  description: 'Jamaah melanjutkan perjalanan dari kuala lumpur ke padang BIM.',
  flightInfo: '',
  mealInfo: 'MAKAN\nPagi, Siang,\nMalam',
),



                        ],
                      ),
                    ),
                  ),

                  // ✅ Bottom NavBar
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
