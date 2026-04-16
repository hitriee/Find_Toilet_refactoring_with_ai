import 'package:find_toilet/shared/utils/global_utils.dart';
import 'package:find_toilet/shared/utils/icon_image.dart';
import 'package:find_toilet/shared/utils/style.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:find_toilet/shared/widgets/button.dart';
import 'package:find_toilet/shared/widgets/modal.dart';
import 'package:find_toilet/shared/widgets/text_widget.dart';
import 'package:find_toilet/presentation/view_models/review_form_view_model.dart';
import 'package:flutter/material.dart';

class ReviewForm extends StatefulWidget {
  final int toiletId;
  final String toiletName;
  final double? preScore;
  final String? preComment;
  final int reviewId;
  final bool showReview;
  final ReturnVoid afterWork;
  const ReviewForm({
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
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  late final ReviewFormViewModel _viewModel;

  Future<void> onSubmit() async {
    final result = await _viewModel.submit(
      reviewId: widget.reviewId,
      toiletId: widget.toiletId,
    );

    if (!mounted) return;

    if (result.success) {
      final title = widget.reviewId != 0 ? '리뷰 수정' : '리뷰 등록';
      showModal(
        context,
        page: AlertModal(
          title: title,
          content: widget.reviewId != 0
              ? '리뷰가 성공적으로\n 수정되었습니다'
              : '리뷰가 성공적으로\n 등록되었습니다',
        ),
      ).then((_) {
        routerPop(context)();
        widget.afterWork();
      });
      return;
    }

    showModal(
      context,
      page: AlertModal(
        title: '오류 발생',
        content: '오류가 발생해 \n리뷰가 ${result.actionLabel}되지 않았습니다.',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _viewModel = ReviewFormViewModel();
    _viewModel.addListener(() {
      if (!mounted) return;
      setState(() {});
    });

    _viewModel.init(
      reviewId: widget.reviewId,
      preComment: widget.preComment,
      preScore: widget.preScore,
    );
  }

  @override
  Widget build(BuildContext context) {
    final reviewCommentValue = _viewModel.reviewData['comment'] as String?;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 2,
              child: CustomText(
                title: widget.toiletName,
                fontSize: FontSize.largeSize,
                color: CustomColors.whiteColor,
                font: kimm,
              ),
            ),
            const Flexible(
              child: CustomText(
                title: '어떠셨나요?',
                color: CustomColors.whiteColor,
              ),
            ),
            Flexible(
              flex: 2,
              child: reviewScore(),
            ),
            Flexible(
              flex: 5,
              child: CustomTextField(
                initValue: reviewCommentValue,
                onChanged: _viewModel.changeComment,
                maxLines: 5,
                height: 200,
                // textHeight: 1.5,
                padding: const EdgeInsetsDirectional.all(20),
              ),
            ),
            Flexible(
              flex: 3,
              child: reviewButtons(context),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox reviewScore() {
    final score = (_viewModel.reviewData['score'] as num?)?.toDouble() ?? 0.0;
    return SizedBox(
      width: screenWidth(context) * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < 5; i += 1)
            Flexible(
              child: CustomIconButton(
                onPressed: () => _viewModel.changeScore(i),
                icon: starIcon,
                iconSize: 50,
                color: i < score
                    ? CustomColors.yellowColor
                    : CustomColors.whiteColor,
              ),
            ),
        ],
      ),
    );
  }

  Row reviewButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          onPressed: routerPop(context),
          buttonText: '취소',
          buttonColor: whiteColor,
        ),
        CustomButton(
          onPressed: () {
            onSubmit();
          },
          buttonText: widget.reviewId != 0 ? '수정' : '등록',
          buttonColor: redColor,
          textColor: CustomColors.whiteColor,
        ),
      ],
    );
  }
}
