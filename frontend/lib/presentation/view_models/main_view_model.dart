import 'package:find_toilet/domain/repositories/toilet_repository.dart';
import 'package:find_toilet/presentation/view_models/main_search_provider.dart';
import 'package:find_toilet/presentation/view_models/review_bookmark_view_model.dart';
import 'package:find_toilet/presentation/view_models/scroll_provider.dart';
import 'package:flutter/foundation.dart';

class MainViewModel extends ChangeNotifier {
  final ToiletRepository _repository;

  MainViewModel({required ToiletRepository repository})
      : _repository = repository;

  Future<void> loadInitial(bool showReview) async {
    MainSearchProvider().setMainPage(0);
    ScrollProvider().setLoading(true);
    ScrollProvider().initPage();

    if (!showReview) {
      ReviewBookMarkProvider().initHeightList();
      MainSearchProvider().initToiletList();
      final query =
          Map<String, dynamic>.from(MainSearchProvider().mainToiletData);
      query['page'] = ScrollProvider().page;
      query['size'] = 20;
      final list = await _repository.getNearToilet(query);
      MainSearchProvider().addToiletList(list);
      ReviewBookMarkProvider().setHeightListSize();
    } else {
      ReviewBookMarkProvider().initReviewList();
      await ReviewBookMarkProvider().getReviewList(ScrollProvider().page);
    }

    ScrollProvider().increasePage();
    ScrollProvider().setLoading(false);
  }

  Future<void> refreshMain(int index, bool showReview) async {
    if (ScrollProvider().loading) {
      ScrollProvider().initPage();
      ReviewBookMarkProvider().initHeightList();

      if (!showReview) {
        MainSearchProvider().initToiletList();
        final query =
            Map<String, dynamic>.from(MainSearchProvider().mainToiletData);
        query['page'] = ScrollProvider().page;
        query['size'] = 20;
        final list = await _repository.getNearToilet(query);
        MainSearchProvider().addToiletList(list);
        ReviewBookMarkProvider().setHeightListSize();
      } else {
        ReviewBookMarkProvider().initReviewList();
        await ReviewBookMarkProvider().getReviewList(ScrollProvider().page);
      }

      ScrollProvider().increasePage();
      ScrollProvider().setLoading(false);
    }
  }
}
