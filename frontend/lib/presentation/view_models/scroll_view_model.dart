//* width, height
class ScrollViewModel with ChangeNotifier {
  static int? _totalPages;
  static bool _loading = true;
  static int _page = 0;
  static bool _working = false;
  static bool _additional = false;

  bool get loading => _loading;
  bool get working => _working;
  bool get additional => _additional;
  int? get totalPages => _totalPages;
  int get page => _page;

  void increasePage() {
    _setPage(_page + 1);
    notifyListeners();
  }

  void initPage() {
    _setPage(0);
    notifyListeners();
  }

  void setWorking(bool newVal) {
    _setWorking(newVal);
    notifyListeners();
  }

  void setAdditional(bool newVal) {
    _setAdditional(newVal);
    notifyListeners();
  }

  void setTotal(int? newVal) {
    _setTotal(newVal);
    notifyListeners();
  }

  void setLoading(bool value) {
    _setLoading(value);
    notifyListeners();
  }

  //* private
  void _setWorking(bool newVal) => _working = newVal;
  void _setAdditional(bool newVal) => _additional = newVal;
  void _setPage(int newVal) => _page = newVal;
  void _setTotal(int? newVal) => _totalPages = newVal;
  void _setLoading(bool value) => _loading = value;
}
