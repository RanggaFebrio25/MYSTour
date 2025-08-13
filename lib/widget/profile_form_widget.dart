import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileFormWidget extends StatefulWidget {
  const ProfileFormWidget({super.key});

  @override
  State<ProfileFormWidget> createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  File? _profileImage;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController(); // ➕ Tambahkan umur
  String _gender = 'Laki-laki';

  @override
  void initState() {
    super.initState();
    _loadSavedProfile();
  }

  Future<void> _loadSavedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('user_name') ?? '';
      _ageController.text = prefs.getString('user_age') ?? ''; // ➕ Load umur
      _gender = prefs.getString('user_gender') ?? 'Laki-laki';
      final imagePath = prefs.getString('user_image');
      if (imagePath != null && File(imagePath).existsSync()) {
        _profileImage = File(imagePath);
      }
    });
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _nameController.text);
    await prefs.setString('user_age', _ageController.text); // ➕ Simpan umur
    await prefs.setString('user_gender', _gender);
    if (_profileImage != null) {
      await prefs.setString('user_image', _profileImage!.path);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profil berhasil disimpan")),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Foto Profil
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.orange.shade200,
            backgroundImage:
                _profileImage != null ? FileImage(_profileImage!) : null,
            child: _profileImage == null
                ? const Icon(Icons.camera_alt, color: Colors.white, size: 40)
                : null,
          ),
        ),
        const SizedBox(height: 16),

        // Nama Lengkap
        TextFormField(
          controller: _nameController,
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
          ),
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 16),

        // ➕ Umur
        TextFormField(
          controller: _ageController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Umur",
            labelStyle: const TextStyle(color: Colors.black),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 16),

        // Jenis Kelamin
        DropdownButtonFormField<String>(
          value: _gender,
          decoration: InputDecoration(
            labelText: "Jenis Kelamin",
            labelStyle: const TextStyle(color: Colors.black),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
            DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
          ],
          onChanged: (value) {
            setState(() {
              _gender = value!;
            });
          },
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 24),

        // Tombol Simpan
        ElevatedButton.icon(
          onPressed: _saveProfile,
          icon: const Icon(Icons.save),
          label: const Text("Simpan"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}
