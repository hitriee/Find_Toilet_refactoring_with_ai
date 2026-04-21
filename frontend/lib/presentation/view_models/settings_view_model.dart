//* setttings
import 'package:find_toilet/domain/repositories/settings_repository.dart';
import 'package:find_toilet/shared/utils/settings_utils.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static late bool _hideModal;
  static late int _magnigyIdx, _radiusIdx;
  static int? _fontIdx;
  static String? _fontState;
  static late String _magnigyState, _radiusState;
  final List<StringList> _optionList = [
    ['표시 안 함', '표시함'],
    ['큰 글씨', '기본'],
    ['500m', '1km', '1.5km'],
  ];
  final _valueList = [500, 1000, 1500];

  get fontState => _fontState;
  get magnigyState => _magnigyState;
  get radiusState => _radiusState;
  get radius => _valueList[_radiusIdx];
  get hideModal => _hideModal;

  FutureBool initSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _magnigyIdx = prefs.getInt('magnigyIdx') ?? 0;
    _magnigyState = _optionList[0][_magnigyIdx];

    final font = prefs.getInt('fontIdx');
    if (font != null) {
      _fontIdx = font;
      _fontState = _optionList[1][_fontIdx!];
    }

    _radiusIdx = prefs.getInt('radiusIdx') ?? 1;
    _radiusState = _optionList[2][_radiusIdx];

    _hideModal = prefs.getBool('join') ?? false;
    notifyListeners();

    return true;
  }

//* public
  void initOption(bool option) {
    if (option) {
      _applyShowMagnify();
      _setShowMagnify();
    }
    _initFont(option);
    _setFont();
    notifyListeners();
  }

  void applyOption(int menuIdx) {
    switch (menuIdx) {
      case 0:
        _applyShowMagnify();
        _setShowMagnify();
        break;
      case 1:
        _applyFont();
        _setFont();
        break;
      default:
        _applyRadius();
        _setRadius();
    }
    notifyListeners();
  }

  void setJoin() {
    _setJoin();
    notifyListeners();
  }

//* private
  void _initFont(bool option) {
    _fontIdx = option ? 0 : 1;
    _fontState = _optionList[1][_fontIdx!];
  }

  void _setFont() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fontIdx', _fontIdx!);
  }

  void _applyFont() {
    _fontIdx = 1 - _fontIdx!;
    _fontState = _optionList[1][_fontIdx!];
  }

  void _setRadius() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('radiusIdx', _radiusIdx);
  }

  void _applyRadius() {
    _radiusIdx += 1;
    if (_radiusIdx >= 3) _radiusIdx = 0;
    _radiusState = _optionList[2][_radiusIdx];
  }

  void _setShowMagnify() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('magnigyIdx', _magnigyIdx);
  }

  void _applyShowMagnify() {
    _magnigyIdx = 1 - _magnigyIdx;
    _magnigyState = _optionList[0][_magnigyIdx];
  }

  void _setJoin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('join', true);
    _hideModal = true;
  }
}

/// Settings 화면 전용 ViewModel — 로그인·이메일 비즈니스 로직을 담당합니다.
class SettingsViewModel extends ChangeNotifier {
  final SettingsRepository _repository;

  SettingsViewModel({required SettingsRepository repository})
      : _repository = repository;

  /// 카카오 로그인을 시도하고 결과 Map을 반환합니다.
  FutureDynamicMap login() => _repository.login();

  /// 이메일 앱 전송을 시도합니다.
  /// 성공 시 null, 실패 시 모달에 표시할 본문 문자열을 반환합니다.
  Future<String?> sendEmail() async {
    String? emailBody;
    try {
      emailBody = await _repository.buildEmailBody();
      await _repository.sendEmail(emailBody);
      return null;
    } catch (_) {
      return emailBody ?? inquiryBody();
    }
  }
}
