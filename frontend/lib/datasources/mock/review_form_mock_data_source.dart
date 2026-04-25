import 'package:find_toilet/data/datasources/mock/mock_review_db.dart';
import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

/// 백엔드 없이 UI 확인용 더미 데이터 소스.
/// 리뷰 데이터는 [MockReviewDb]에서 가져옵니다.
class ReviewFormMockDataSource {
  Future<ReviewModel> getReview(int reviewId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final review = MockReviewDb.findById(reviewId);
    if (review == null) {
      throw Exception('Mock: 리뷰를 찾을 수 없습니다 (reviewId: $reviewId)');
    }
    return review;
  }

  Future<bool> postNewReview({
    required int toiletId,
    required DynamicMap reviewData,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }

  Future<DynamicMap> updateReview(
    int reviewId, {
    required DynamicMap reviewData,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return reviewData;
  }
}
