import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/pages/review_form/domain/review_model.dart';

abstract class ReviewFormDataSourceRepository {
  Future<ReviewList> getReviewList(int toiletId, int page);
  Future<ReviewModel> getReview(int reviewId);
  FutureBool postNewReview({
    required int toiletId,
    required DynamicMap reviewData,
  });
  FutureDynamicMap updateReview(
    int reviewId, {
    required DynamicMap reviewData,
  });
  Future<bool> deleteReview(int reviewId);
}
