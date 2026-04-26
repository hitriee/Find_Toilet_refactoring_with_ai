import 'package:find_toilet/pages/select_theme/domain/select_theme_repository.dart';
import 'package:flutter/foundation.dart';

class SelectThemeViewModel extends ChangeNotifier {
  final SelectThemeRepository _repository;

  bool _isLargeFont = true;
  bool get isLargeFont => _isLargeFont;

  SelectThemeViewModel({required SelectThemeRepository repository})
      : _repository = repository;

  void changeFontSize(bool isLarge) {
    if (_isLargeFont != isLarge) {
      _isLargeFont = isLarge;
      notifyListeners();
    }
  }

  Future<void> applyTheme() async {
    await _repository.saveTheme(_isLargeFont);
  }
}
