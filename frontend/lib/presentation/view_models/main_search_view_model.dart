//* main, search
class MainSearchViewModel with ChangeNotifier {
  static GlobalKey? _globalKey;
  static final List<int> _selectedMarker = [];
  static final StringList _sortValues = ['distance', 'score', 'comment'];
  static double? _lat;
  static double? _lng;
  static int _sortIdx = 0;
  static bool _showAll = true;
  static final ToiletList _mainToiletList = [];
  static final DynamicMap _mainToiletData = {
    'allDay': false,
    'diaper': false,
    'disabled': false,
    'kids': false,
    'lat': _lat,
    'lon': _lng,
    'radius': 1000,
    'page': 0,
    'size': 20,
  };

  static final ToiletList _searchToiletList = [];

  static final DynamicMap _searchData = {
    'allDay': false,
    'diaper': false,
    'disabled': false,
    'kids': false,
    'keyword': null,
    'lat': _lat,
    'lon': _lng,
    'page': 0,
    'size': 20,
    'order': _sortValues[_sortIdx]
  };

  //* getter
  GlobalKey? get globalKey => _globalKey;

  bool get diaper => _mainToiletData['diaper'];
  bool get kids => _mainToiletData['kids'];
  bool get disabled => _mainToiletData['disabled'];
  bool get allDay => _mainToiletData['allDay'];
  bool get showAll => _showAll;
  int get sortIdx => _sortIdx;
  int? get selectedMarker =>
      _selectedMarker.isNotEmpty ? _selectedMarker.last : null;

  double? get lat => _lat;
  double? get lng => _lng;

  ToiletList get mainToiletList => _mainToiletList;
  DynamicMap get mainToiletData => _mainToiletData;

  ToiletList get searchToiletList => _searchToiletList;
  //* public
  void changeShow() {
    _changeShow();
    notifyListeners();
  }

  void setMarker(int index) {
    _setMarker(index);
    notifyListeners();
  }

  void initMarker() => _initMarker();

  void removeMarker() {
    _removeMarker();
    notifyListeners();
  }

  void setKey(GlobalKey key) {
    _setKey(key);
    notifyListeners();
  }

  void setFilter(int index, bool value) {
    _setFilter(index, value);
    notifyListeners();
  }

  void setSortIdx(int index) {
    _setSortIdx(index);
    notifyListeners();
  }

  void addToiletList(ToiletList toiletList) {
    _addToiletList(toiletList);
    notifyListeners();
  }

  void initToiletList() => _initToiletList();

  void setLatLng(double newLat, double newLng) {
    _setLatLng(newLat, newLng);
    _applyLatLng();
    notifyListeners();
  }

  void setMainPage(int newVal) => _setMainPage(newVal);
  void setSearchPage(int newVal) => _setSearchPage(newVal);

  FutureToiletList getMainToiletList(int page) => _getMainToiletList(page);

  FutureToiletList getSearchList(int page) => _getSearchList(page);

  void setSearchData(DynamicMap newData) => _setSearchData(newData);

  void initSearchList() => _initSearchList();
  void setRadius(int value) => _setRadius(value);

  //* private
  void _changeShow() => _showAll = !_showAll;
  void _setMarker(int index) => _selectedMarker.add(index);
  void _initMarker() => _selectedMarker.clear();
  void _removeMarker() {
    if (_selectedMarker.isNotEmpty) {
      _selectedMarker.removeLast();
    }
  }

  FutureToiletList _getMainToiletList(int page) async {
    final toiletData = await ToiletProvider().getNearToilet(_mainToiletData);
    _setMainPage(page + 1);
    _addToiletList(toiletData);
    notifyListeners();
    return toiletData;
  }

  FutureToiletList _getSearchList(int page) async {
    final toiletData = await ToiletProvider().searchToilet(_searchData);
    _setSearchPage(page + 1);
    _searchToiletList.addAll(toiletData);
    notifyListeners();
    return toiletData;
  }

  void _initSearchList() => _searchToiletList.clear();

  void _setSearchData(DynamicMap newData) async {
    _searchData.addAll(newData);
    _searchData['order'] = _sortValues[_sortIdx];
    notifyListeners();
  }

  void _setLatLng(double newLat, double newLng) {
    _lat = newLat;
    _lng = newLng;
  }

  void _applyLatLng() {
    _mainToiletData['lat'] = _lat;
    _mainToiletData['lon'] = _lng;
    _searchData['lat'] = _lat;
    _searchData['lon'] = _lng;
  }

  void _setMainPage(int newVal) => _mainToiletData['page'] = newVal;
  void _setSearchPage(int newVal) => _searchData['page'] = newVal;

  void _setKey(GlobalKey key) => _globalKey = key;

  void _setFilter(int index, bool value) {
    switch (index) {
      case 0:
        _mainToiletData['diaper'] = value;
        return;
      case 1:
        _mainToiletData['kids'] = value;
        return;
      case 2:
        _mainToiletData['disabled'] = value;
        return;
      default:
        _mainToiletData['allDay'] = value;
        return;
    }
  }

  void _setSortIdx(int index) => _sortIdx = index;

  void _addToiletList(ToiletList toiletList) =>
      _mainToiletList.addAll(toiletList);

  void _initToiletList() => _mainToiletList.clear();

  void _setRadius(int value) => _mainToiletData['radius'] = value;
}
