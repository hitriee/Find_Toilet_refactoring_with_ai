import 'package:find_toilet/core/config/app_config.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/remote/review_form_remote_data_source.dart';
import 'package:find_toilet/pages/review_form/data/review_form_mock_repository_impl.dart';
import 'package:find_toilet/pages/review_form/data/review_form_repository_impl.dart';
import 'package:find_toilet/pages/review_form/domain/review_form_repository.dart';
import 'package:find_toilet/pages/review_form/presentation/review_form_view.dart';
import 'package:find_toilet/pages/review_form/presentation/review_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewFormPage extends StatelessWidget {
  final int toiletId;
  final String toiletName;
  final double? preScore;
  final String? preComment;
  final int reviewId;
  final bool showReview;
  final ReturnVoid afterWork;

  const ReviewFormPage({
    super.key,
    required this.toiletName,
    required this.toiletId,
    this.preComment,
    this.preScore,
    required this.reviewId,
    required this.showReview,
    required this.afterWork,
  });

  @override
  Widget build(BuildContext context) {
    final ReviewFormRepository repository = kMockMode
        ? ReviewFormMockRepositoryImpl()
        : ReviewFormRepositoryImpl(remote: ReviewFormRemoteDataSource());

    return ChangeNotifierProvider(
      create: (_) => ReviewFormViewModel(repository: repository)
        ..init(
          reviewId: reviewId,
          toiletId: toiletId,
          preComment: preComment,
          preScore: preScore,
        ),
      child: ReviewFormView(
        toiletName: toiletName,
        reviewId: reviewId,
        showReview: showReview,
        afterWork: afterWork,
      ),
    );
  }
}
