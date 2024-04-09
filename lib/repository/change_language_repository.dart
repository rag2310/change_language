import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguageRepository {
  Future<void> changeLanguageEnglish() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("lang", "en");
  }

  Future<void> changeLanguageSpanish() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("lang", "es");
  }

  Future<String> getLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("lang") ?? "en";
  }
}
