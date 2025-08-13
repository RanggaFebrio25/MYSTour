import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'home_screen.dart'; // Halaman setelah splash

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    await Future.delayed(const Duration(seconds: 5)); // Waktu splash

    // ✅ Minta izin lokasi
    var status = await Permission.location.request();

    if (status.isDenied || status.isPermanentlyDenied) {
      // Arahkan ke pengaturan jika ditolak
      await openAppSettings();
      return; // Jangan lanjut jika tidak diizinkan
    }

    // Jika izin diberikan, lanjut ke home screen
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background3.png', // ganti sesuai path gambarmu
            fit: BoxFit.cover,
          ),
          // Center(
          //   child: Text(
          //     'Splash Screen...',
          //     style: TextStyle(
          //       fontSize: 24,
          //       color: Colors.white, // supaya teks kelihatan di atas gambar
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
