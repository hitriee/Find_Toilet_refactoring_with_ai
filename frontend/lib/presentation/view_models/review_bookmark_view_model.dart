//* review, book mark
class ReviewBookMarkViewModel with ChangeNotifier {
  static ToiletModel? _toiletInfo;
  static int? _toiletId;
  static double? _itemHeight;
  static final ReviewList _reviewList = [];
  static final ToiletList _bookmarkList = [];
  static final List<double> _heightList = [];

  //* get
  ToiletModel? get toiletInfo => _toiletInfo;
  int? get toiletId => _toiletId;
  double? get itemHeight => _itemHeight;
  ReviewList get reviewList => _reviewList;
  ToiletList get bookmarkList => _bookmarkList;
  List<double> get heightList => _heightList;

  //* private
  //* review
  FutureReviewList _getReviewList(int page) async {
    final reviewData = await ReviewProvider().getReviewList(_toiletId!, page);
    _addReviewList(reviewData);
    notifyListeners();
    return reviewData;
  }

  void _addReviewList(ReviewList reviewData) => _reviewList.addAll(reviewData);
  void _initReviewList() => _reviewList.clear();
  void _setItemHeight(int i) => _itemHeight = _heightList[i];
  void _setToiletInfo(ToiletModel toiletData) {
    _toiletInfo = toiletData;
    _toiletId = toiletData.toiletId;
  }

  void _initToiletInfo() {
    _toiletInfo = null;
    _toiletId = null;
  }

  void _initHeightList() => _heightList.clear();

  void _setHeightListSize() =>
      _heightList.addAll(List.generate(20, (index) => 0));

  void _setHeight(int i, double newHeight) => _heightList[i] = newHeight;

  //* bookmark
  FutureToiletList _getBookmarkList(int folderId, int page) async {
    final bookmarkList = await BookMarkProvider().getToiletList(folderId, page);
    _addBookmarkList(bookmarkList);
    return bookmarkList;
  }

  void _addBookmarkList(ToiletList bookmarkList) =>
      _bookmarkList.addAll(bookmarkList);

  void _initBookmarkList() => _bookmarkList.clear();

  //* public
  void addReviewList(ReviewList reviewData) => _addReviewList(reviewData);

  FutureToiletList getBookmarkList(int folderId, int page) =>
      _getBookmarkList(folderId, page);

  void initReviewList() => _initReviewList();
  FutureReviewList getReviewList(int page) => _getReviewList(page);

  void setItemHeight(int i) {
    _setItemHeight(i);
    notifyListeners();
  }

  void setToiletInfo(ToiletModel toiletData) {
    _setToiletInfo(toiletData);
    notifyListeners();
  }

  void initToiletInfo() => _initToiletInfo();

  void initBookmarkList() => _initBookmarkList();

  void initHeightList() => _initHeightList();

  void setHeightListSize() {
    _setHeightListSize();
    notifyListeners();
  }

  void setHeight(int i, double newHeight) {
    _setHeight(i, newHeight);
    notifyListeners();
  }
}
