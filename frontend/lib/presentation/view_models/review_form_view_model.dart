import 'package:flutter/foundation.dart';
import 'package:find_toilet/core/network/review_provider.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

class ReviewFormSubmitResult {
  final bool success;
  final String actionLabel;

  const ReviewFormSubmitResult({
    required this.success,
    required this.actionLabel,
  });
}

/// ReviewForm Screen에서 네트워크 호출/에러 처리/버튼 중복 클릭 방지를 담당합니다.
class ReviewFormViewModel extends ChangeNotifier {
  final ReviewProvider _reviewProvider;

  ReviewFormViewModel({ReviewProvider? reviewProvider})
      : _reviewProvider = reviewProvider ?? ReviewProvider();

  DynamicMap reviewData = {'comment': '', 'score': 0.0};
  bool enabled = true;

  Future<void> init({
    required int reviewId,
    String? preComment,
    double? preScore,
  }) async {
    if (reviewId != 0 && preComment != null && preScore != null) {
      reviewData = {
        'comment': preComment,
        'score': preScore,
      };
      notifyListeners();
      return;
    }

    if (reviewId == 0) return;
    final review = await _reviewProvider.getReview(reviewId);
    reviewData = {
      'comment': review.comment,
      'score': review.score,
    };
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
    reviewData = {
      ...reviewData,
      'comment': comment.trim(),
    };
    notifyListeners();
  }

  Future<ReviewFormSubmitResult> submit({
    required int reviewId,
    required int toiletId,
  }) async {
    if (!enabled) {
      return ReviewFormSubmitResult(
        success: false,
        actionLabel: reviewId == 0 ? '등록' : '수정',
      );
    }

    enabled = false;
    notifyListeners();

    try {
      if (reviewId == 0) {
        await _reviewProvider.postNewReview(
          toiletId: toiletId,
          reviewData: reviewData,
        );
      } else {
        await _reviewProvider.updateReview(
          reviewId,
          reviewData: reviewData,
        );
      }
      return ReviewFormSubmitResult(
        success: true,
        actionLabel: reviewId == 0 ? '등록' : '수정',
      );
    } catch (_) {
      return ReviewFormSubmitResult(
        success: false,
        actionLabel: reviewId == 0 ? '등록' : '수정',
      );
    } finally {
      enabled = true;
      notifyListeners();
    }
  }
}

