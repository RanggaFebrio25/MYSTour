import 'package:flutter/material.dart';
import '../tentang_page.dart';
import '../management_page.dart';
import '../legalitas_page.dart';
import '../enteneri_page.dart';
import '../paket_umroh_page.dart';
import '../galeri_page.dart';
import '../sertifikat_jamaah_page.dart';
import '../paket_roaming_page.dart';
import '../pendaftaran_umroh_page.dart';



class MenuGridWidget extends StatefulWidget {
  const MenuGridWidget({super.key});

  @override
  State<MenuGridWidget> createState() => _MenuGridWidgetState();
}

class _MenuGridWidgetState extends State<MenuGridWidget> {
  int? tappedIndex;

  void _handleTap(int index, VoidCallback? onTap) async {
    setState(() {
      tappedIndex = index;
    });

    // Beri waktu 200ms untuk efek hitam
    await Future.delayed(const Duration(milliseconds: 200));

    onTap?.call();

    // Reset kembali setelah kembali
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      setState(() {
        tappedIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuItems = [
      MenuItem(
        // icon: Icons.home,
        imagePath: 'assets/menu1.png',
        title: 'Tentang MYS',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TentangPage())),
      ),
      MenuItem(
        imagePath: 'assets/menu2.png',
        title: 'Management MYS',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManagementPage())),
      ),
      MenuItem(
        imagePath: 'assets/menu3.png',
        title: 'Legalitas MYS',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LegalitasPage())),
      ),
      MenuItem(
        imagePath: 'assets/menu4.png',
        title: 'Enteneri Perjalanan',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EnteneriPage())),
      ),
      MenuItem(
        imagePath: 'assets/menu5.png',
        title: 'Paket Umroh\n& Haji Plus',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaketUmrohPage())),
      ),
      MenuItem(
        imagePath: 'assets/menu6.png',
        title: 'Galeri kegiatan',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GaleriPage())),
      ),
      MenuItem(
  imagePath: 'assets/menu7.png',
  title: 'Sertifikat Jamaah',
  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SertifikatJamaahPage())),
),

      MenuItem(
  imagePath: 'assets/menu8.png',
  title: 'Paket Roaming',
  onTap: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const PaketRoamingPage()),
  ),
),

     MenuItem(
  imagePath: 'assets/menu9.png',
  title: 'Pendaftaran\nUmroh & Haji',
  onTap: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const PendaftaranUmrohPage()),
  ),
),

    ];

    return Padding(
      padding: const EdgeInsets.all(6),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 0.2,
          crossAxisSpacing: 0.2,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          final isTapped = tappedIndex == index;

          return GestureDetector(
            onTap: () => _handleTap(index, item.onTap),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isTapped ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
  child: item.imagePath != null
      ? Image.asset(
          item.imagePath!,
          width: 36,
          height: 36,
          color: isTapped ? Colors.white : null, // Optional: untuk efek tap
        )
      : Icon(
          item.icon,
          size: 40,
          color: isTapped ? Colors.white : Colors.orange,
        ),
),

                ),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MenuItem {
  final String? imagePath; // tambahkan path gambar
  final IconData? icon; // tetap ada untuk fallback
  final String title;
  final VoidCallback? onTap;

  MenuItem({this.imagePath, this.icon, required this.title, this.onTap});
}

