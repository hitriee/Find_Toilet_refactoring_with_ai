import 'package:find_toilet/core/config/scroll_provider.dart';
import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/repositories/review_form_data_source_repository.dart';
import 'package:find_toilet/pages/review_form/domain/review_model.dart';

class ReviewFormRemoteDataSource extends ApiProvider
    implements ReviewFormDataSourceRepository {
  @override
  Future<ReviewList> getReviewList(int toiletId, int page) async {
    ReviewList reviewList = [];
    try {
      final response = token == null
          ? await dio.get(
              reviewListUrl(toiletId),
              queryParameters: {'page': page},
            )
          : await dioWithToken(url: reviewListUrl(toiletId), method: 'GET').get(
              reviewListUrl(toiletId),
              queryParameters: {'page': page},
            );
      switch (response.statusCode) {
        case 200:
          final data = response.data['data'];
          data.forEach((review) {
            reviewList.add(ReviewModel.fromJson(review));
          });
          ScrollProvider().setTotal(response.data['size']);
          return reviewList;
        case 204:
          ScrollProvider().setTotal(0);
          return [];
        default:
          throw Exception('리뷰 목록 조회 실패: 상태 코드 ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('리뷰 목록 조회 중 오류 발생: $error');
    }
  }

  @override
  Future<ReviewModel> getReview(int reviewId) async {
    final response = await dioWithToken(url: reviewUrl(reviewId), method: 'GET')
        .get(reviewUrl(reviewId));
    return ReviewModel.fromJson(response.data['data']);
  }

  @override
  FutureBool postNewReview({
    required int toiletId,
    required DynamicMap reviewData,
  }) =>
      createApi(postReviewUrl(toiletId), data: reviewData);

  @override
  FutureDynamicMap updateReview(
    int reviewId, {
    required DynamicMap reviewData,
  }) =>
      updateApi(updateReviewUrl(reviewId), data: reviewData);

  @override
  FutureBool deleteReview(int reviewId) => deleteApi(deleteReviewUrl(reviewId));
}
