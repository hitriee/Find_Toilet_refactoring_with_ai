import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/mock/review_form_mock_data_source.dart';
import 'package:find_toilet/pages/review_form/domain/review_form_repository.dart';
import 'package:find_toilet/pages/review_form/domain/review_model.dart';

class ReviewFormMockRepositoryImpl implements ReviewFormRepository {
  final _dataSource = ReviewFormMockDataSource();

  @override
  Future<ReviewList> getReviewList(int toiletId, int page) =>
      _dataSource.getReviewList(toiletId, page);

  @override
  Future<ReviewModel> getReview(int reviewId) =>
      _dataSource.getReview(reviewId);

  @override
  FutureBool postNewReview({
    required int toiletId,
    required DynamicMap reviewData,
  }) =>
      _dataSource.postNewReview(toiletId: toiletId, reviewData: reviewData);

  @override
  FutureDynamicMap updateReview(
    int reviewId, {
    required DynamicMap reviewData,
  }) =>
      _dataSource.updateReview(reviewId, reviewData: reviewData);

  @override
  FutureBool deleteReview(int reviewId) => _dataSource.deleteReview(reviewId);
}
