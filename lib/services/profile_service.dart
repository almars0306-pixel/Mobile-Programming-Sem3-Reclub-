import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class ProfileService {
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<void> saveProfile(String name, String email) async {
    await _prefs.setString('user_name', name);
    await _prefs.setString('user_email', email);
  }

  Future<UserModel> getProfile() async {
    final name = await _prefs.getString('user_name') ?? 'Rizky';
    final email = await _prefs.getString('user_email') ?? 'rizky@email.com';
    
    return UserModel(name: name, email: email);
  }
}