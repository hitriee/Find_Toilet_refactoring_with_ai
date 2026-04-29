export 'package:find_toilet/core/utils/nav_utils.dart';
export 'package:find_toilet/core/utils/user_utils.dart';
export 'package:find_toilet/core/utils/settings_utils.dart';
export 'package:find_toilet/core/utils/scroll_utils.dart';
export 'package:find_toilet/core/utils/map_utils.dart';
export 'package:find_toilet/core/utils/review_utils.dart';

import 'package:find_toilet/core/config/state_provider.dart';
import 'package:find_toilet/core/utils/map_utils.dart';
import 'package:find_toilet/core/utils/review_utils.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* init main data
FutureList initMainData(
  BuildContext context, {
  required bool showReview,
  required bool needClear,
}) {
  if (needClear) {
    showReview ? initReviewList(context) : initToiletList(context);
  }
  return showReview ? getReviewList(context) : getMainToiletList(context);
}

//* scroll 초기화
void initLoadingData(BuildContext context, {bool? isMain, bool? isSearch}) {
  if (isMain == true) {
    context.read<MapStateProvider>().setMainPage(0);
  }
  context.read<ScrollProvider>().setLoading(true);
  context.read<ScrollProvider>().initPage();
  context.read<ScrollProvider>().setAdditional(false);
  context.read<ScrollProvider>().setWorking(false);
}
