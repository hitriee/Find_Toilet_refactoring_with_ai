import 'package:flutter/foundation.dart';

/// 페이지네이션·로딩 등 스크롤 목록 공통 상태.
/// 레거시 코드가 `ScrollProvider()` 싱글톤으로 total을 갱신하므로 동일 인스턴스를 반환합니다.
class ScrollProvider extends ChangeNotifier {
  ScrollProvider._();
  static final ScrollProvider _instance = ScrollProvider._();
  factory ScrollProvider() => _instance;

  bool _loading = true;
  int _page = 0;
  int? _totalPages;
  bool _working = false;
  bool _additional = false;

  bool get loading => _loading;
  int get page => _page;
  int? get totalPages => _totalPages;
  bool get working => _working;
  bool get additional => _additional;

  void setLoading(bool value) {
    if (_loading == value) {
      return;
    }
    _loading = value;
    notifyListeners();
  }

  void setTotal(int? value) {
    if (_totalPages == value) {
      return;
    }
    _totalPages = value;
    notifyListeners();
  }

  void increasePage() {
    _page += 1;
    notifyListeners();
  }

  void initPage() {
    _page = 0;
    notifyListeners();
  }

  void setWorking(bool value) {
    if (_working == value) {
      return;
    }
    _working = value;
    notifyListeners();
  }

  void setAdditional(bool value) {
    if (_additional == value) {
      return;
    }
    _additional = value;
    notifyListeners();
  }
}
