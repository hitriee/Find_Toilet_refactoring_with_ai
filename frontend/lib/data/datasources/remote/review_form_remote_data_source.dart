import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

class ReviewFormRemoteDataSource extends ApiProvider {
  Future<ReviewModel> getReview(int reviewId) async {
    final response =
        await dioWithToken(url: reviewUrl(reviewId), method: 'GET')
            .get(reviewUrl(reviewId));
    return ReviewModel.fromJson(response.data['data']);
  }

  FutureBool postNewReview({
    required int toiletId,
    required DynamicMap reviewData,
  }) =>
      createApi(postReviewUrl(toiletId), data: reviewData);

  FutureDynamicMap updateReview(
    int reviewId, {
    required DynamicMap reviewData,
  }) =>
      updateApi(updateReviewUrl(reviewId), data: reviewData);
}
