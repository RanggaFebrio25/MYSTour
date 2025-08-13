import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String hintText;

  const SearchBarWidget({
    Key? key,
    this.onChanged,
    this.hintText = 'Cari sesuatu...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), // lebih rapat ke atas/bawah
      child: SizedBox(
        height: 36, // tinggi lebih ramping
        child: TextField(
          decoration: InputDecoration(
  isDense: true,
  hintText: hintText,
  hintStyle: const TextStyle(fontSize: 14),
  prefixIcon: const Icon(Icons.search, color: Colors.orange, size: 20),
  filled: true,
  fillColor: Colors.orange.shade50,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide.none,
  ),
  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
),
          style: const TextStyle(fontSize: 14), // teks input lebih kecil
          onChanged: onChanged,
        ),
      ),
    );
  }
}
