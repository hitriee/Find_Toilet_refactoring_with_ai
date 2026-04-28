import 'package:find_toilet/core/config/scroll_provider.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/mock/mock_review_db.dart';
import 'package:find_toilet/pages/review_form/domain/review_model.dart';

/// 백엔드 없이 UI 확인용 더미 데이터 소스.
/// 리뷰 데이터는 [MockReviewDb]에서 가져옵니다.
class ReviewFormMockDataSource {
  Future<ReviewList> getReviewList(int toiletId, int page) async {
    await Future.delayed(const Duration(milliseconds: 400));
    ScrollProvider().setTotal(MockReviewDb.totalPagesFor(toiletId));
    return MockReviewDb.getByToilet(toiletId, page);
  }

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

  Future<bool> deleteReview(int reviewId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }
}
