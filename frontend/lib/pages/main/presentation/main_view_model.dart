import 'package:find_toilet/core/config/state_provider.dart';
import 'package:find_toilet/core/domain/toilet_repository.dart';
import 'package:find_toilet/pages/review_form/domain/review_form_repository.dart';
import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier {
  final ToiletRepository _toiletRepository;
  final ReviewFormRepository _reviewRepository;

  MainViewModel({
    required ToiletRepository toiletRepository,
    required ReviewFormRepository reviewRepository,
  })  : _toiletRepository = toiletRepository,
        _reviewRepository = reviewRepository;

  Future<void> loadInitial(bool showReview) async {
    MapStateProvider().setMainPage(0);
    ScrollProvider().setLoading(true);
    ScrollProvider().initPage();

    if (!showReview) {
      ReviewBookmarkStateProvider().initHeightList();
      MapStateProvider().initToiletList();
      final query =
          Map<String, dynamic>.from(MapStateProvider().mainToiletData);
      query['page'] = ScrollProvider().page;
      query['size'] = 20;
      final list = await _toiletRepository.getNearToilet(query);
      MapStateProvider().addToiletList(list);
      ReviewBookmarkStateProvider().setHeightListSize();
    } else {
      ReviewBookmarkStateProvider().initReviewList();
      final toiletId = ReviewBookmarkStateProvider().toiletId!;
      final reviewData =
          await _reviewRepository.getReviewList(toiletId, ScrollProvider().page);
      ReviewBookmarkStateProvider().addReviewList(reviewData);
    }

    ScrollProvider().increasePage();
    ScrollProvider().setLoading(false);
  }

  Future<void> refreshMain(int index, bool showReview) async {
    if (!ScrollProvider().loading) {
      ScrollProvider().initPage();
      ReviewBookmarkStateProvider().initHeightList();

      if (!showReview) {
        MapStateProvider().initToiletList();
        final query =
            Map<String, dynamic>.from(MapStateProvider().mainToiletData);
        query['page'] = ScrollProvider().page;
        query['size'] = 20;
        final list = await _toiletRepository.getNearToilet(query);
        MapStateProvider().addToiletList(list);
        ReviewBookmarkStateProvider().setHeightListSize();
      } else {
        ReviewBookmarkStateProvider().initReviewList();
        final toiletId = ReviewBookmarkStateProvider().toiletId!;
        final reviewData = await _reviewRepository.getReviewList(
            toiletId, ScrollProvider().page);
        ReviewBookmarkStateProvider().addReviewList(reviewData);
      }

      ScrollProvider().increasePage();
      ScrollProvider().setLoading(false);
    }
  }

  void setScaffoldKey(GlobalKey<ScaffoldState> key) {
    MapStateProvider().setKey(key);
  }
}
