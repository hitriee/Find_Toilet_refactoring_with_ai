// ignore_for_file: use_build_context_synchronously

import 'package:find_toilet/core/utils/global_utils.dart';
import 'package:find_toilet/core/utils/icon_image.dart';
import 'package:find_toilet/core/utils/style.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/core/widgets/button.dart';
import 'package:find_toilet/core/widgets/modal.dart';
import 'package:find_toilet/core/widgets/text_widget.dart';
import 'package:find_toilet/pages/review_form/presentation/review_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewFormView extends StatelessWidget {
  final String toiletName;
  final int reviewId;
  final bool showReview;
  final ReturnVoid afterWork;

  const ReviewFormView({
    super.key,
    required this.toiletName,
    required this.reviewId,
    required this.showReview,
    required this.afterWork,
  });

  Future<void> _onSubmit(BuildContext context) async {
    final vm = context.read<ReviewFormViewModel>();
    final result = await vm.submit();

    if (!context.mounted) return;

    if (result.success) {
      final title = reviewId != 0 ? '리뷰 수정' : '리뷰 등록';
      showModal(
        context,
        page: AlertModal(
          title: title,
          content:
              reviewId != 0 ? '리뷰가 성공적으로\n 수정되었습니다' : '리뷰가 성공적으로\n 등록되었습니다',
        ),
      ).then((_) {
        routerPop(context)();
        afterWork();
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
  Widget build(BuildContext context) {
    final vm = context.watch<ReviewFormViewModel>();
    final reviewCommentValue = vm.reviewData['comment'] as String?;

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
                title: toiletName,
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
              child: _reviewScore(context, vm),
            ),
            Flexible(
              flex: 5,
              child: CustomTextField(
                initValue: reviewCommentValue,
                onChanged: vm.changeComment,
                maxLines: 5,
                height: 200,
                padding: const EdgeInsetsDirectional.all(20),
              ),
            ),
            Flexible(
              flex: 3,
              child: _reviewButtons(context),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _reviewScore(BuildContext context, ReviewFormViewModel vm) {
    final score = (vm.reviewData['score'] as num?)?.toDouble() ?? 0.0;
    return SizedBox(
      width: screenWidth(context) * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < 5; i += 1)
            Flexible(
              child: CustomIconButton(
                onPressed: () => vm.changeScore(i),
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

  Row _reviewButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          onPressed: routerPop(context),
          buttonText: '취소',
          buttonColor: whiteColor,
        ),
        CustomButton(
          onPressed: () => _onSubmit(context),
          buttonText: reviewId != 0 ? '수정' : '등록',
          buttonColor: redColor,
          textColor: CustomColors.whiteColor,
        ),
      ],
    );
  }
}
