import 'package:find_toilet/domain/repositories/review_form_repository.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:flutter/foundation.dart';

class ReviewFormSubmitResult {
  final bool success;
  final String actionLabel;

  const ReviewFormSubmitResult({
    required this.success,
    required this.actionLabel,
  });
}

class ReviewFormViewModel extends ChangeNotifier {
  final ReviewFormRepository _repository;

  ReviewFormViewModel({required ReviewFormRepository repository})
      : _repository = repository;

  DynamicMap reviewData = {'comment': '', 'score': 0.0};
  bool enabled = true;
  late int _reviewId;
  late int _toiletId;

  Future<void> init({
    required int reviewId,
    required int toiletId,
    String? preComment,
    double? preScore,
  }) async {
    _reviewId = reviewId;
    _toiletId = toiletId;

    if (reviewId != 0 && preComment != null && preScore != null) {
      reviewData = {'comment': preComment, 'score': preScore};
      notifyListeners();
      return;
    }

    if (reviewId == 0) return;

    final review = await _repository.getReview(reviewId);
    reviewData = {'comment': review.comment, 'score': review.score};
    notifyListeners();
  }

  void changeScore(int i) {
    if (!enabled) return;
    reviewData = {
      ...reviewData,
      // UI는 i(0..4) 기반이라 +1 해서 score(1..5)로 매핑합니다.
      'score': (i + 1).toDouble(),
    };
    notifyListeners();
  }

  void changeComment(String comment) {
    if (!enabled) return;
    reviewData = {...reviewData, 'comment': comment.trim()};
    notifyListeners();
  }

  Future<ReviewFormSubmitResult> submit() async {
    final actionLabel = _reviewId == 0 ? '등록' : '수정';

    if (!enabled) {
      return ReviewFormSubmitResult(success: false, actionLabel: actionLabel);
    }

    enabled = false;
    notifyListeners();

    try {
      if (_reviewId == 0) {
        await _repository.postNewReview(
          toiletId: _toiletId,
          reviewData: reviewData,
        );
      } else {
        await _repository.updateReview(_reviewId, reviewData: reviewData);
      }
      return ReviewFormSubmitResult(success: true, actionLabel: actionLabel);
    } catch (_) {
      return ReviewFormSubmitResult(success: false, actionLabel: actionLabel);
    } finally {
      enabled = true;
      notifyListeners();
    }
  }
}
