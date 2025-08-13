import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'auth_service.dart';
import 'dashboard.dart';
import 'profile_page.dart';
import 'about_page.dart';
import 'notification_page.dart';
import 'widget/CustomBottomNavBar.dart';
import 'widget/search_bar_widget.dart';  // pastikan import ini

class SertifikatJamaahPage extends StatefulWidget {
  const SertifikatJamaahPage({super.key});

  @override
  State<SertifikatJamaahPage> createState() => _SertifikatJamaahPageState();
}

class _SertifikatJamaahPageState extends State<SertifikatJamaahPage> {
  final int _selectedIndex = 0;
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();

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
    // Kamu bisa proses input pencarian di sini
    print("Search query: $query");
  }

  Future<void> _cetakSertifikatDariGambar() async {
    final pdf = pw.Document();

    final Uint8List imageBytes = await rootBundle
        .load('assets/sertifikat_template.png')
        .then((value) => value.buffer.asUint8List());
    final image = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              pw.Positioned.fill(
                child: pw.Image(image, fit: pw.BoxFit.cover),
              ),
              pw.Positioned(
                top: 380,
                left: 0,
                right: 0,
                child: pw.Center(
                  child: pw.Text(
                    _namaController.text,
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                ),
              ),
              pw.Positioned(
                top: 450,
                left: 0,
                right: 0,
                child: pw.Center(
                  child: pw.Text(
                    _tanggalController.text,
                    style: pw.TextStyle(
                      fontSize: 18,
                      color: PdfColors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
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
                  // Custom AppBar
                  Material(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 36, left: 16, right: 16, bottom: 12),
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

                  // Container Putih (Form) dengan Search Bar di atas TextField
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                          
                            // Search Bar Widget ditambahkan di sini
                            SearchBarWidget(
                              onChanged: _onSearchChanged,
                            ),
                            const SizedBox(height: 24),
                             const Text(
                              "Form Sertifikat Jamaah",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
const SizedBox(height: 24),
                            TextField(
                              controller: _namaController,
                              decoration: const InputDecoration(
                                labelText: "Nama Lengkap",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _tanggalController,
                              decoration: const InputDecoration(
                                labelText: "Tanggal Keberangkatan",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: _cetakSertifikatDariGambar,
                              icon: const Icon(Icons.download),
                              label: const Text("Cetak & Download Sertifikat"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            )
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
