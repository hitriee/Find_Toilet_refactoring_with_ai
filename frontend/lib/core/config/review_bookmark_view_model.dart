//* review, bookmark
import 'package:find_toilet/core/domain/toilet_model.dart';
import 'package:find_toilet/core/network/bookmark_provider.dart';
import 'package:find_toilet/core/network/review_provider.dart';
import 'package:find_toilet/core/utils/type_enum.dart';

import 'package:flutter/foundation.dart';

class ReviewBookMarkProvider extends ChangeNotifier {
  static ToiletModel? _toiletInfo;
  static int? _toiletId;
  static double? _itemHeight;
  static final ReviewList _reviewList = [];
  static final ToiletList _bookmarkList = [];
  static final List<double> _heightList = [];

  ToiletModel? get toiletInfo => _toiletInfo;
  int? get toiletId => _toiletId;
  double? get itemHeight => _itemHeight;
  ReviewList get reviewList => List.unmodifiable(_reviewList);
  ToiletList get bookmarkList => List.unmodifiable(_bookmarkList);
  List<double> get heightList => List.unmodifiable(_heightList);

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
      _heightList.addAll(List<double>.generate(20, (_) => 0));

  void _setHeight(int i, double newHeight) => _heightList[i] = newHeight;

  void _addBookmarkList(ToiletList bookmarkData) =>
      _bookmarkList.addAll(bookmarkData);

  void _initBookmarkList() => _bookmarkList.clear();

  FutureReviewList _getReviewList(int page) async {
    final reviewData = await ReviewProvider().getReviewList(_toiletId!, page);
    _addReviewList(reviewData);
    notifyListeners();
    return reviewData;
  }

  FutureToiletList _getBookmarkList(int folderId, int page) async {
    final list = await BookMarkProvider().getToiletList(folderId, page);
    _addBookmarkList(list);
    return list;
  }

  void addReviewList(ReviewList reviewData) {
    _addReviewList(reviewData);
    notifyListeners();
  }

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
