import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PendaftaranFormWidget extends StatefulWidget {
  const PendaftaranFormWidget({super.key});

  @override
  _PendaftaranFormWidgetState createState() => _PendaftaranFormWidgetState();
}

class _PendaftaranFormWidgetState extends State<PendaftaranFormWidget> {
  // Controller untuk semua field
  final namaController = TextEditingController();
  final nikController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final alamatController = TextEditingController();
  final noHpController = TextEditingController();
  final emailController = TextEditingController();
  final pekerjaanController = TextEditingController();
  final ahliWarisController = TextEditingController();
  final jenisSetoranController = TextEditingController();
  final tanggalDaftarController = TextEditingController();
  final namaAgenController = TextEditingController();
  final noHpAgenController = TextEditingController();

  final kwitansiNamaController = TextEditingController();
  final sudahDiterimaDariController = TextEditingController();
  final uangSejumlahController = TextEditingController();
  final untukPembayaranController = TextEditingController();
  final terbilangController = TextEditingController();
  final tanggalController = TextEditingController();
  final tandaTanganController = TextEditingController();

  @override
  void dispose() {
    // Dispose semua controller
    namaController.dispose();
    nikController.dispose();
    tempatLahirController.dispose();
    tanggalLahirController.dispose();
    alamatController.dispose();
    noHpController.dispose();
    emailController.dispose();
    pekerjaanController.dispose();
    ahliWarisController.dispose();
    jenisSetoranController.dispose();
    tanggalDaftarController.dispose();
    namaAgenController.dispose();
    noHpAgenController.dispose();

    kwitansiNamaController.dispose();
    sudahDiterimaDariController.dispose();
    uangSejumlahController.dispose();
    untukPembayaranController.dispose();
    terbilangController.dispose();
    tanggalController.dispose();
    tandaTanganController.dispose();

    super.dispose();
  }

  Future<void> _printForm() async {
    final pdf = pw.Document();

    // Load gambar template kwitansi dari asset ke memory
    final Uint8List imageBytes = await rootBundle
        .load('assets/kwitansi_template.png')
        .then((bd) => bd.buffer.asUint8List());
    final pw.ImageProvider background = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Stack(
            children: [
              // Background gambar kwitansi penuh halaman
              pw.Positioned.fill(
                child: pw.Image(background, fit: pw.BoxFit.cover),
              ),

              // Posisi teks di bagian FORM PENDAFTARAN (sesuaikan koordinat)
              pw.Positioned(
                left: 130,
                top: 195,
                child: pw.Text(namaController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 130,
                top: 210,
                child: pw.Text(nikController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 130,
                top: 225,
                child: pw.Text(tempatLahirController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 130,
                top: 240,
                child: pw.Text(tanggalLahirController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 130,
                top: 250,
                child: pw.Text(alamatController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 130,
                top: 280,
                child: pw.Text(noHpController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 130,
                top: 295,
                child: pw.Text(emailController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 130,
                top: 310,
                child: pw.Text(pekerjaanController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 130,
                top: 323,
                child: pw.Text(ahliWarisController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 130,
                top: 335,
                child: pw.Text(jenisSetoranController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 130,
                top: 353,
                child: pw.Text(tanggalDaftarController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 180,
                top: 365,
                child: pw.Text(namaAgenController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 180,
                top: 378,
                child: pw.Text(noHpAgenController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),

              // Posisi teks di bagian KWITANSI (sesuaikan koordinat)
              pw.Positioned(
                left: 255,
                top: 500,
                child: pw.Text(kwitansiNamaController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                 left: 255,
                top: 500,
                child: pw.Text(sudahDiterimaDariController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 255,
                top: 515,
                child: pw.Text(uangSejumlahController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 255,
                top: 530,
                child: pw.Text(untukPembayaranController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 255,
                top: 550,
                child: pw.Text(terbilangController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                 left:370,
                top: 506,
                child: pw.Text(tanggalController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
              pw.Positioned(
                left: 130,
                top: 650,
                child: pw.Text(tandaTanganController.text,
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.black)),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageBox('assets/bank1.png'),
            const SizedBox(height: 12),
            imageBox('assets/bank2.png'),
            const SizedBox(height: 12),
            imageBox('assets/bank3.png'),
            const SizedBox(height: 24),
            const Center(
              child: Column(
                children: [
                  Text(
                    'PENDAFTARAN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    'UMROH & HAJI',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            buildTextField('Nama Lengkap', namaController),
            buildTextField('NIK', nikController),
            buildTextField('Tempat Lahir', tempatLahirController),
            buildTextField('Tanggal Lahir', tanggalLahirController),
            buildTextField('Alamat Lengkap', alamatController),
            buildTextField('No HP/WA', noHpController),
            buildTextField('E-Mail', emailController),
            buildTextField('Pekerjaan', pekerjaanController),
            buildTextField('Ahli Waris', ahliWarisController),
            buildTextField('Jenis Setoran', jenisSetoranController),
            buildTextField('Tanggal Daftar', tanggalDaftarController),
            buildTextField('Nama Agen/Mitra Syiar', namaAgenController),
            buildTextField('No HP/WA Agen/Mitra Syiar', noHpAgenController),
            const SizedBox(height: 24),
            const Center(
              child: Column(
                children: [
                  Text(
                    'KWITANSI',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    'UMROH & HAJI',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            buildTextField('Nama', kwitansiNamaController),
            buildTextField('Sudah Diterima Dari', sudahDiterimaDariController),
            buildTextField('Uang Sejumlah Rp.', uangSejumlahController),
            buildTextField('Untuk Pembayaran', untukPembayaranController),
            buildTextField('Terbilang', terbilangController),
            buildTextField('Tanggal', tanggalController),
            buildTextField('Tanda Tangan', tandaTanganController),
            const SizedBox(height: 24),

            // Tombol cetak
            Center(
              child: ElevatedButton(
                onPressed: _printForm,  // langsung panggil fungsi cetak PDF
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Cetak',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange, width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget imageBox(String assetPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        assetPath,
        width: double.infinity,
        height: 130,
        fit: BoxFit.contain,
      ),
    );
  }
}
