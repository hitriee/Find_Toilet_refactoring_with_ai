import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/pages/settings/presentation/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

export 'main_search_provider.dart';
export 'review_bookmark_view_model.dart';
export 'scroll_provider.dart';

//* user info
class UserInfoProvider with ChangeNotifier {
  static String? _token, _refresh, _nickname;
  String? get token => _token;
  String? get refresh => _refresh;
  String? get nickname => _nickname;

  //* public

  FutureBool initVar() async {
    final userInfo = await _readStore();
    _setStoreToken(userInfo['token']);
    _setStoreRefresh(userInfo['refresh']);
    _setStoreName(userInfo['nickname']);
    notifyListeners();
    return true;
  }

  void setStoreToken(String? newToken) async {
    _setStoreToken(newToken);
    _setStore('token', newToken);
    notifyListeners();
  }

  void setStoreRefresh(String? newRefresh) {
    _setStoreRefresh(newRefresh);
    _setStore('refresh', newRefresh);
    notifyListeners();
  }

  void setStoreName(String? newName) {
    _setStoreName(newName);
    _setStore('nickname', newName);
    notifyListeners();
  }

  //* private
  void _setStoreToken(String? newToken) => _token = newToken;
  void _setStoreRefresh(String? newRefresh) => _refresh = newRefresh;
  void _setStoreName(String? newName) => _nickname = newName;

  void _setStore(String key, String? value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  Future<StringMap> _readStore() async {
    const storage = FlutterSecureStorage();
    final userInfo = await storage.readAll();
    return userInfo;
  }
}

//* refresh
class ApplyChangeProvider with ChangeNotifier {
  static Space _refresh = Space.empty;
  static String _convertedVar = '';
  static bool _pressedOnce = false;
  String get refresh => _convertedVar;
  bool get pressedOnce => _pressedOnce;

  void refreshPage() {
    _changeRefresh();
    _spaceToString();
    notifyListeners();
  }

  void _changeRefresh() =>
      _refresh = _refresh == Space.empty ? Space.one : Space.empty;

  void _spaceToString() => _convertedVar = convertedSpace(_refresh);

  FutureBool changePressed() => _changePressed();

  FutureBool _changePressed() {
    if (!_pressedOnce) {
      _pressedOnce = true;
      notifyListeners();
      Future.delayed(
        Duration(
          seconds: SettingsProvider().fontState == '기본' ? 2 : 3,
        ),
        () {
          _pressedOnce = false;
          notifyListeners();
        },
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
