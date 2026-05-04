import 'package:find_toilet/core/domain/toilet_model.dart';
import 'package:flutter/foundation.dart';

/// 화장실 상세 바텀시트의 전역 앱 상태 Provider.
///
/// - **선택된 화장실**: 현재 bottom sheet에 표시 중인 화장실 정보 (지도·바텀시트 공유)
/// - **UI 높이**: 리뷰 카드 높이 목록 (BottomSheet 동적 높이 캐시)
///
/// 리뷰 목록은 [MainViewModel]이, 즐겨찾기 목록은 [BookmarkViewModel]이 각각 관리합니다.
class ToiletProvider extends ChangeNotifier {
  ToiletProvider._();
  static final ToiletProvider _instance = ToiletProvider._();
  factory ToiletProvider() => _instance;

  // ── 선택된 화장실 ─────────────────────────────────────────────────────────

  ToiletModel? _toiletInfo;
  int? _toiletId;

  ToiletModel? get toiletInfo => _toiletInfo;
  int? get toiletId => _toiletId;

  void setToiletInfo(ToiletModel toiletData) {
    _toiletInfo = toiletData;
    _toiletId = toiletData.toiletId;
    notifyListeners();
  }

  // void initToiletInfo() {
  //   _toiletInfo = null;
  //   _toiletId = null;
  //   notifyListeners();
  // }

  // ── UI 높이 ───────────────────────────────────────────────────────────────

  double? _itemHeight;
  final List<double> _heightList = [];

  double? get itemHeight => _itemHeight;
  List<double> get heightList => List.unmodifiable(_heightList);

  void setItemHeight(int i) {
    _itemHeight = _heightList[i];
    notifyListeners();
  }

  void setHeightListSize() {
    _heightList.addAll(List<double>.generate(20, (_) => 0));
    notifyListeners();
  }

  void setHeight(int i, double newHeight) {
    _heightList[i] = newHeight;
    notifyListeners();
  }

  void initHeightList() {
    _heightList.clear();
    notifyListeners();
  }
}
