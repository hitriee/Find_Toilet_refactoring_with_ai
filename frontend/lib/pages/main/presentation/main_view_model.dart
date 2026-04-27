import 'package:find_toilet/core/config/state_provider.dart';
import 'package:find_toilet/core/domain/toilet_repository.dart';
import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier {
  final ToiletRepository _repository;

  MainViewModel({required ToiletRepository repository})
      : _repository = repository;

  Future<void> loadInitial(bool showReview) async {
    MapStateProvider().setMainPage(0);
    ScrollProvider().setLoading(true);
    ScrollProvider().initPage();

    if (!showReview) {
      ReviewBookMarkProvider().initHeightList();
      MapStateProvider().initToiletList();
      final query =
          Map<String, dynamic>.from(MapStateProvider().mainToiletData);
      query['page'] = ScrollProvider().page;
      query['size'] = 20;
      final list = await _repository.getNearToilet(query);
      MapStateProvider().addToiletList(list);
      ReviewBookMarkProvider().setHeightListSize();
    } else {
      ReviewBookMarkProvider().initReviewList();
      await ReviewBookMarkProvider().getReviewList(ScrollProvider().page);
    }

    ScrollProvider().increasePage();
    ScrollProvider().setLoading(false);
  }

  Future<void> refreshMain(int index, bool showReview) async {
    if (!ScrollProvider().loading) {
      ScrollProvider().initPage();
      ReviewBookMarkProvider().initHeightList();

      if (!showReview) {
        MapStateProvider().initToiletList();
        final query =
            Map<String, dynamic>.from(MapStateProvider().mainToiletData);
        query['page'] = ScrollProvider().page;
        query['size'] = 20;
        final list = await _repository.getNearToilet(query);
        MapStateProvider().addToiletList(list);
        ReviewBookMarkProvider().setHeightListSize();
      } else {
        ReviewBookMarkProvider().initReviewList();
        await ReviewBookMarkProvider().getReviewList(ScrollProvider().page);
      }

      ScrollProvider().increasePage();
      ScrollProvider().setLoading(false);
    }
  }

  void setScaffoldKey(GlobalKey<ScaffoldState> key) {
    MapStateProvider().setKey(key);
  }
}
