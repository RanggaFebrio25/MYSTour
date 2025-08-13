import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RoamingWidget extends StatefulWidget {
  const RoamingWidget({super.key});

  @override
  State<RoamingWidget> createState() => _RoamingWidgetState();
}

class _RoamingWidgetState extends State<RoamingWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kuotaController = TextEditingController();
  final TextEditingController _nomorController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final List<String> _imagePaths = [
    'assets/roaming1.png',
    'assets/roaming2.png',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      final next = (_currentIndex + 1) % _imagePaths.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() => _currentIndex = next);
      _startAutoPlay();
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final nama = _namaController.text;
      final kuota = _kuotaController.text;
      final nomor = _nomorController.text;

      final pesan = Uri.encodeComponent(
        "Halo Admin, saya ingin pesan paket roaming:\n"
        "Nama: $nama\n"
        "Jumlah Kuota: $kuota GB\n"
        "Nomor HP: $nomor"
      );

      const adminWa = "6282268331738"; // Ganti ke nomor WhatsApp admin
      final url = "https://wa.me/$adminWa?text=$pesan";

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka WhatsApp')),
        );
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _namaController.dispose();
    _kuotaController.dispose();
    _nomorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.4,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _imagePaths.length,
              onPageChanged: (i) => setState(() => _currentIndex = i),
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  _imagePaths[index],
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_imagePaths.length, (index) {
              return Container(
                width: _currentIndex == index ? 12 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Colors.orange
                      : Colors.grey.shade400,
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Form Pemesanan Paket Roaming",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        controller: _namaController,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: "Nama Lengkap",
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (val) =>
            val == null || val.isEmpty ? "Wajib diisi" : null,
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _kuotaController,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: "Jumlah Kuota (GB)",
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (val) =>
            val == null || val.isEmpty ? "Wajib diisi" : null,
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _nomorController,
        keyboardType: TextInputType.phone,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: "Nomor HP/WA",
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (val) =>
            val == null || val.isEmpty ? "Wajib diisi" : null,
      ),
      const SizedBox(height: 20),
      ElevatedButton.icon(
        onPressed: _submitForm,
        icon: const Icon(Icons.send),
        label: const Text("Kirim via WhatsApp"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    ],
  ),
)

        ],
      ),
    );
  }
}
