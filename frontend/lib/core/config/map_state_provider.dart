import 'package:find_toilet/core/domain/toilet_model.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:flutter/material.dart';

/// 지도 화면의 전역 앱 상태 Provider.
///
/// - **위치**: 현재 위도·경도·탐색 반경
/// - **필터**: 편의시설 필터(기저귀·유아·장애인·24시간), 정렬 기준
/// - **UI**: 화면 표시 모드, 선택된 마커 인덱스, ScaffoldKey
/// - **화장실 목록**: 지도에 표시할 주변 화장실 목록 (상태만 보관)
///
/// 데이터 로딩은 각 화면의 ViewModel([MainViewModel] 등)이 담당합니다.
class MapStateProvider extends ChangeNotifier {
  MapStateProvider._();
  static final MapStateProvider _instance = MapStateProvider._();
  factory MapStateProvider() => _instance;

  // ── 위치 ──────────────────────────────────────────────────────────────────

  double? lat;
  double? lng;
  int radius = 1000;

  void setLatLng(double newLat, double newLng) {
    lat = newLat;
    lng = newLng;
    notifyListeners();
  }

  void setRadius(int value) {
    radius = value;
    notifyListeners();
  }

  // ── 필터 ──────────────────────────────────────────────────────────────────

  bool diaper = false;
  bool kids = false;
  bool disabled = false;
  bool allDay = false;
  int sortIdx = 0;

  void setFilter(int index, bool value) {
    switch (index) {
      case 0:
        diaper = value;
        break;
      case 1:
        kids = value;
        break;
      case 2:
        disabled = value;
        break;
      default:
        allDay = value;
    }
    notifyListeners();
  }

  void setSortIdx(int index) {
    sortIdx = index;
    notifyListeners();
  }

  // ── UI 상태 ───────────────────────────────────────────────────────────────

  bool showAll = true;
  int? selectedMarker;
  GlobalKey<ScaffoldState>? globalKey;

  void changeShow() {
    showAll = !showAll;
    notifyListeners();
  }

  void setMarker(int i) {
    selectedMarker = i;
    notifyListeners();
  }

  void removeMarker() {
    selectedMarker = null;
    notifyListeners();
  }

  void setKey(GlobalKey<ScaffoldState> key) {
    globalKey = key;
    notifyListeners();
  }

  // ── 주변 화장실 목록 ──────────────────────────────────────────────────────

  final List<ToiletModel> _mainToiletList = [];

  ToiletList get mainToiletList => List.unmodifiable(_mainToiletList);

  void addToiletList(ToiletList toiletList) {
    _mainToiletList.addAll(toiletList);
    notifyListeners();
  }

  void initToiletList() {
    _mainToiletList.clear();
    notifyListeners();
  }

  // ── API 쿼리 파라미터 빌더 ────────────────────────────────────────────────

  DynamicMap get mainToiletData => {
        'lon': lng,
        'lat': lat,
        'radius': radius,
        'allDay': allDay,
        'disabled': disabled,
        'kids': kids,
        'diaper': diaper,
      };

  // ── 레거시 호환 no-op ─────────────────────────────────────────────────────

  /// [global_utils.initLoadingData]와의 호환을 위해 유지합니다.
  void setMainPage(int _) => notifyListeners();
}
