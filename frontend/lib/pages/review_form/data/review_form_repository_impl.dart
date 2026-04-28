import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/remote/review_form_remote_data_source.dart';
import 'package:find_toilet/pages/review_form/domain/review_form_repository.dart';
import 'package:find_toilet/pages/review_form/domain/review_model.dart';

class ReviewFormRepositoryImpl implements ReviewFormRepository {
  final ReviewFormRemoteDataSource remote;

  ReviewFormRepositoryImpl({required this.remote});

  @override
  Future<ReviewList> getReviewList(int toiletId, int page) async {
    try {
      return await remote.getReviewList(toiletId, page);
    } catch (e) {
      throw Exception('리뷰 목록을 불러오는 데 실패했습니다.');
    }
  }

  @override
  Future<ReviewModel> getReview(int reviewId) async {
    try {
      return await remote.getReview(reviewId);
    } catch (e) {
      throw Exception('리뷰를 불러오는 데 실패했습니다.');
    }
  }

  @override
  FutureBool postNewReview({
    required int toiletId,
    required DynamicMap reviewData,
  }) async {
    try {
      return await remote.postNewReview(
        toiletId: toiletId,
        reviewData: reviewData,
      );
    } catch (e) {
      throw Exception('리뷰 등록에 실패했습니다.');
    }
  }

  @override
  FutureDynamicMap updateReview(
    int reviewId, {
    required DynamicMap reviewData,
  }) async {
    try {
      return await remote.updateReview(reviewId, reviewData: reviewData);
    } catch (e) {
      throw Exception('리뷰 수정에 실패했습니다.');
    }
  }

  @override
  FutureBool deleteReview(int reviewId) async {
    try {
      return await remote.deleteReview(reviewId);
    } catch (e) {
      throw Exception('리뷰 삭제에 실패했습니다.');
    }
  }
}
