import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> register(String name, String phone, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('phone', phone);
    await prefs.setString('password', password);
  }

  static Future<bool> login(String phone, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedPhone = prefs.getString('phone');
    final savedPassword = prefs.getString('password');
    return phone == savedPhone && password == savedPassword;
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  static Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  // Hanya hapus status login, bukan data user
  await prefs.setBool('isLoggedIn', true);
}

}
