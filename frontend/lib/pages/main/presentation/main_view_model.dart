import 'package:find_toilet/core/config/state_provider.dart';
import 'package:find_toilet/core/domain/toilet_repository.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/pages/review_form/domain/review_form_repository.dart';
import 'package:find_toilet/pages/review_form/domain/review_model.dart';
import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier {
  final ToiletRepository _toiletRepository;
  final ReviewFormRepository _reviewRepository;

  MainViewModel({
    required ToiletRepository toiletRepository,
    required ReviewFormRepository reviewRepository,
  })  : _toiletRepository = toiletRepository,
        _reviewRepository = reviewRepository;

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

  Future<void> loadInitial(bool showReview) async {
    MapStateProvider().setMainPage(0);
    ScrollProvider().setLoading(true);
    ScrollProvider().initPage();

    if (!showReview) {
      ToiletProvider().initHeightList();
      MapStateProvider().initToiletList();
      final query =
          Map<String, dynamic>.from(MapStateProvider().mainToiletData);
      query['page'] = ScrollProvider().page;
      query['size'] = 20;
      final list = await _toiletRepository.getNearToilet(query);
      MapStateProvider().addToiletList(list);
      ToiletProvider().setHeightListSize();
    } else {
      initReviewList();
      final toiletId = ToiletProvider().toiletId!;
      final reviewData = await _reviewRepository.getReviewList(
          toiletId, ScrollProvider().page);
      addReviewList(reviewData);
    }

    ScrollProvider().increasePage();
    ScrollProvider().setLoading(false);
  }

  Future<void> refreshMain(int index, bool showReview) async {
    ScrollProvider().initPage();
    ToiletProvider().initHeightList();

    if (!showReview) {
      MapStateProvider().initToiletList();
      final query =
          Map<String, dynamic>.from(MapStateProvider().mainToiletData);
      query['page'] = ScrollProvider().page;
      query['size'] = 20;
      final list = await _toiletRepository.getNearToilet(query);
      MapStateProvider().addToiletList(list);
      ToiletProvider().setHeightListSize();
    } else {
      initReviewList();
      final toiletId = ToiletProvider().toiletId!;
      final reviewData = await _reviewRepository.getReviewList(
          toiletId, ScrollProvider().page);
      addReviewList(reviewData);
    }

    ScrollProvider().increasePage();
    ScrollProvider().setLoading(false);
  }

  Future<void> refreshToiletDetail(int toiletId) async {
    final data = await _toiletRepository.getToilet(toiletId);
    ToiletProvider().setToiletInfo(data);
  }

  void setScaffoldKey(GlobalKey<ScaffoldState> key) {
    MapStateProvider().setKey(key);
  }
}
