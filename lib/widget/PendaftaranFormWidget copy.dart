import 'package:flutter/material.dart';

class PendaftaranFormWidget extends StatelessWidget {
  const PendaftaranFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ Gambar Vertikal dari Aset
            imageBox('assets/bank1.png'),
            const SizedBox(height: 12),
            imageBox('assets/bank2.png'),
            const SizedBox(height: 12),
            imageBox('assets/bank3.png'),
            const SizedBox(height: 24),

            // ✅ Judul & Subjudul
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

            // ✅ Form Pendaftaran
            buildTextField('Nama Lengkap'),
            buildTextField('NIK'),
            buildTextField('Tempat Lahir'),
            buildTextField('Tanggal Lahir'),
            buildTextField('Alamat Lengkap'),
            buildTextField('No HP/WA'),
            buildTextField('E-Mail'),
            buildTextField('Pekerjaan'),
            buildTextField('Ahli Waris'),
            buildTextField('Jenis Setoran'),
            buildTextField('Tanggal Daftar'),
            buildTextField('Nama Agen/Mitra Syiar'),
            buildTextField('No HP/WA Agen/Mitra Syiar'),

            const SizedBox(height: 24),

            // ✅ Judul Kwitansi di Tengah
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

            // ✅ Form Kwitansi
            buildTextField('Nama'),  
            buildTextField('Sudah Diterima Dari'),
            buildTextField('Uang Sejumlah Rp.'),
            buildTextField('Untuk Pembayaran'),
            buildTextField('Terbilang'),
            buildTextField('Tanggal'),
            buildTextField('Tanda Tangan'),

            const SizedBox(height: 24),

            // ✅ Tombol Kirim
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Tambahkan logika pengiriman
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Kirim',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ TextField dengan garis orange dan border bulat
  Widget buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: TextField(
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  // ✅ Gambar dari asset dengan BoxFit.contain agar tidak terpotong
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
