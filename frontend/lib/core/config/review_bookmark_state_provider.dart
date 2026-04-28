import 'package:find_toilet/core/domain/toilet_model.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/pages/review_form/domain/review_model.dart';
import 'package:flutter/foundation.dart';

/// 화장실 상세 · 리뷰 · 즐겨찾기 목록 화면의 전역 앱 상태 Provider.
///
/// - **선택된 화장실**: 현재 bottom sheet에 표시 중인 화장실 정보
/// - **리뷰 목록**: 해당 화장실의 리뷰 목록 (상태만 보관)
/// - **즐겨찾기 목록**: 폴더별 즐겨찾기 목록 (상태만 보관)
/// - **UI 높이**: 리뷰 카드 높이 목록 (동적 높이 계산용)
///
/// 데이터 로딩은 각 ViewModel 또는 [global_utils]의 헬퍼가 담당합니다.
class ReviewBookmarkStateProvider extends ChangeNotifier {
  ReviewBookmarkStateProvider._();
  static final ReviewBookmarkStateProvider _instance =
      ReviewBookmarkStateProvider._();
  factory ReviewBookmarkStateProvider() => _instance;

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

  void initToiletInfo() {
    _toiletInfo = null;
    _toiletId = null;
    notifyListeners();
  }

  // ── 리뷰 목록 ─────────────────────────────────────────────────────────────

  final List<ReviewModel> _reviewList = [];

  ReviewList get reviewList => List.unmodifiable(_reviewList);

  void addReviewList(ReviewList reviewData) {
    _reviewList.addAll(reviewData);
    notifyListeners();
  }

  void initReviewList() {
    _reviewList.clear();
    notifyListeners();
  }

  // ── 즐겨찾기 목록 ─────────────────────────────────────────────────────────

  final List<ToiletModel> _bookmarkList = [];

  ToiletList get bookmarkList => List.unmodifiable(_bookmarkList);

  void addBookmarkList(ToiletList bookmarkData) {
    _bookmarkList.addAll(bookmarkData);
    notifyListeners();
  }

  void initBookmarkList() {
    _bookmarkList.clear();
    notifyListeners();
  }

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
