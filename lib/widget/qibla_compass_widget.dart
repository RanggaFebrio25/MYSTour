import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';

class QiblaCompassWidget extends StatefulWidget {
  const QiblaCompassWidget({super.key});

  @override
  State<QiblaCompassWidget> createState() => _QiblaCompassWidgetState();
}

class _QiblaCompassWidgetState extends State<QiblaCompassWidget> {
  Future<bool> _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return false;
    }

    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkPermissions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!) {
          return const Center(
            child: Text(
              'Izin lokasi tidak tersedia atau belum aktif.',
              textAlign: TextAlign.center,
            ),
          );
        }

        return StreamBuilder<QiblahDirection>(
          stream: FlutterQiblah.qiblahStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('Tidak ada data arah kiblat.'));
            }

            final direction = snapshot.data!.direction; // arah utara HP
            final qiblah = snapshot.data!.qiblah;       // sudut kiblat dari utara

            // Hitung sudut jarum kiblat agar selalu menunjuk Ka'bah
            final qiblahNeedleAngle = ((qiblah - direction) * (pi / 180));

            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Kompas berputar mengikuti arah perangkat
                  Transform.rotate(
                    angle: (-direction) * (pi / 180),
                    child: Image.asset(
                      'assets/compass.png',
                      width: 300,
                      height: 300,
                    ),
                  ),

                  // Jarum menunjuk arah kiblat
                  Transform.rotate(
                    angle: qiblahNeedleAngle,
                    child: Image.asset(
                      'assets/needle.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
