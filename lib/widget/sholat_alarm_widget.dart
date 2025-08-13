import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class SholatAlarmWidget extends StatefulWidget {
  const SholatAlarmWidget({super.key});

  @override
  State<SholatAlarmWidget> createState() => _SholatAlarmWidgetState();
}

class _SholatAlarmWidgetState extends State<SholatAlarmWidget> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final List<String> labels = ['Subuh', 'Dzuhur', 'Ashar', 'Maghrib', 'Isya'];
  final List<TimeOfDay> prayerTimes = [
    TimeOfDay(hour: 4, minute: 39),
    TimeOfDay(hour: 11, minute: 57),
    TimeOfDay(hour: 13, minute: 18),
    TimeOfDay(hour: 17, minute: 50),
    TimeOfDay(hour: 19, minute: 4),
  ];

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _initNotifications();
  }

  void _initNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> _scheduleAllAlarms() async {
    for (int i = 0; i < prayerTimes.length; i++) {
      final now = DateTime.now();
      final time = prayerTimes[i];
      final scheduled = DateTime(now.year, now.month, now.day, time.hour, time.minute);

      final scheduleTime = scheduled.isBefore(now)
          ? scheduled.add(const Duration(days: 1))
          : scheduled;

      await flutterLocalNotificationsPlugin.zonedSchedule(
        i,
        'Waktu Sholat: ${labels[i]}',
        'Sudah masuk waktu sholat ${labels[i]}',
        tz.TZDateTime.from(scheduleTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'sholat_channel',
            'Jadwal Sholat',
            channelDescription: 'Notifikasi waktu sholat',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Notifikasi sholat berhasil dijadwalkan")),
      );
    }
  }

  @override
Widget build(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16.0),
    children: [
      ...List.generate(prayerTimes.length, (i) {
        final time = prayerTimes[i];
        final formatted = time.format(context);
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labels[i],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  Text(formatted, style: const TextStyle(fontSize: 15)),
                  const SizedBox(width: 5),
                  const Text("WIB"),
                  const SizedBox(width: 10),
                  const Icon(Icons.access_time, color: Colors.orange, size: 20),
                ],
              ),
            ],
          ),
        );
      }),
      const SizedBox(height: 20),
      ElevatedButton.icon(
        onPressed: _scheduleAllAlarms,
        icon: const Icon(Icons.notifications_active),
        label: const Text("Aktifkan Notifikasi"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    ],
  );
}
}


