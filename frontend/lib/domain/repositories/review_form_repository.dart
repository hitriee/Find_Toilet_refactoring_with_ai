import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

abstract class ReviewFormRepository {
  Future<ReviewModel> getReview(int reviewId);

  FutureBool postNewReview({
    required int toiletId,
    required DynamicMap reviewData,
  });

  FutureDynamicMap updateReview(
    int reviewId, {
    required DynamicMap reviewData,
  });
}
