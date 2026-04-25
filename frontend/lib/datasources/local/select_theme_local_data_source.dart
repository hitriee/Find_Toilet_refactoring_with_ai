import 'package:shared_preferences/shared_preferences.dart';

class SelectThemeLocalDataSource {
  Future<void> saveTheme(bool isLargeFont) async {
    final prefs = await SharedPreferences.getInstance();
    final fontIdx = isLargeFont ? 0 : 1;
    await prefs.setInt('fontIdx', fontIdx);
    if (isLargeFont) {
      await prefs.setInt('magnigyIdx', 1);
    }
  }
}
