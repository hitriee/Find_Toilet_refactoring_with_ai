import 'package:find_toilet/core/network/toilet_provider.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:flutter/material.dart';

/// 지도·주변 목록·필터·좌표 등 메인 화면 상태.
/// 검색 결과 목록은 [SearchViewModel]로 이전되었습니다.
class MainSearchProvider extends ChangeNotifier {
  MainSearchProvider._();
  static final MainSearchProvider _instance = MainSearchProvider._();
  factory MainSearchProvider() => _instance;

  final List<ToiletModel> _mainToiletList = [];

  double? lat;
  double? lng;
  int radius = 1000;
  bool diaper = false;
  bool kids = false;
  bool disabled = false;
  bool allDay = false;
  int sortIdx = 0;
  bool showAll = true;
  int? selectedMarker;
  GlobalKey<ScaffoldState>? globalKey;

  ToiletList get mainToiletList => List.unmodifiable(_mainToiletList);

  DynamicMap get mainToiletData => {
        'lon': lng,
        'lat': lat,
        'radius': radius,
        'allDay': allDay,
        'disabled': disabled,
        'kids': kids,
        'diaper': diaper,
      };

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

  void setLatLng(double newLat, double newLng) {
    lat = newLat;
    lng = newLng;
    notifyListeners();
  }

  void setRadius(int value) {
    radius = value;
    notifyListeners();
  }

  void changeShow() {
    showAll = !showAll;
    notifyListeners();
  }

  void addToiletList(ToiletList toiletList) {
    _mainToiletList.addAll(toiletList);
    notifyListeners();
  }

  void initToiletList() {
    _mainToiletList.clear();
    notifyListeners();
  }

  void setMainPage(int newVal) {
    notifyListeners();
  }

  void setKey(GlobalKey<ScaffoldState> key) {
    globalKey = key;
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

  FutureToiletList getMainToiletList(int page) async {
    final query = Map<String, dynamic>.from(mainToiletData);
    query['page'] = page;
    query['size'] = 20;
    final list = await ToiletProvider().getNearToilet(query);
    addToiletList(list);
    return list;
  }

  /// 레거시 global_utils 호환용. 검색 UI는 [SearchViewModel]을 사용합니다.
  ToiletList get searchToiletList => const [];

  FutureToiletList getSearchList(int page) async => [];

  void initSearchList() {}

  void setSearchPage(int newVal) {}

  void setSearchData(DynamicMap searchData) {
    notifyListeners();
  }
}
