import 'package:find_toilet/data/datasources/mock/review_form_mock_data_source.dart';
import 'package:find_toilet/domain/repositories/review_form_repository.dart';
import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

class ReviewFormMockRepositoryImpl implements ReviewFormRepository {
  final _dataSource = ReviewFormMockDataSource();

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
}
