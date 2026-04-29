import 'package:find_toilet/core/config/state_provider.dart';
import 'package:find_toilet/core/domain/toilet_model.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/remote/bookmark_remote_data_source.dart';
import 'package:find_toilet/datasources/remote/review_form_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* review list
void addReviewList(BuildContext context, ReviewList reviewData) =>
    context.read<ReviewBookmarkStateProvider>().addReviewList(reviewData);

ReviewList reviewList(BuildContext context) =>
    context.read<ReviewBookmarkStateProvider>().reviewList;

ToiletModel? getToilet(BuildContext context) =>
    context.read<ReviewBookmarkStateProvider>().toiletInfo;

void setToilet(BuildContext context, ToiletModel toiletModel) =>
    context.read<ReviewBookmarkStateProvider>().setToiletInfo(toiletModel);

double? getItemHeight(BuildContext context) =>
    context.read<ReviewBookmarkStateProvider>().itemHeight;

void setItemHeight(BuildContext context, int i) =>
    context.read<ReviewBookmarkStateProvider>().setItemHeight(i);

int? getToiletId(BuildContext context) =>
    context.read<ReviewBookmarkStateProvider>().toiletId;

FutureReviewList getReviewList(BuildContext context) async {
  final toiletId = ReviewBookmarkStateProvider().toiletId!;
  final reviewData = await ReviewFormRemoteDataSource()
      .getReviewList(toiletId, ScrollProvider().page);
  addReviewList(context, reviewData);
  return reviewData;
}

void initReviewList(BuildContext context) =>
    context.read<ReviewBookmarkStateProvider>().initReviewList();

double? getHeight(BuildContext context, int i) =>
    context.read<ReviewBookmarkStateProvider>().heightList.length > i
        ? context.read<ReviewBookmarkStateProvider>().heightList[i]
        : null;

void setHeightListSize(BuildContext context) =>
    context.read<ReviewBookmarkStateProvider>().setHeightListSize();

void setHeight(BuildContext context, int i, double newHeight) =>
    context.read<ReviewBookmarkStateProvider>().setHeight(i, newHeight);

void initHeightList(BuildContext context) =>
    context.read<ReviewBookmarkStateProvider>().initHeightList();

//* bookmark list
ToiletList bookmarkList(BuildContext context) =>
    context.read<ReviewBookmarkStateProvider>().bookmarkList;

FutureToiletList getBookmarkList(
  BuildContext context, {
  required int folderId,
}) async {
  final list = await BookmarkRemoteDataSource()
      .getToiletList(folderId, ScrollProvider().page);
  context.read<ReviewBookmarkStateProvider>().addBookmarkList(list);
  return list;
}

void initBookmarkList(BuildContext context) =>
    context.read<ReviewBookmarkStateProvider>().initBookmarkList();

//* search list (SearchViewModel이 자체 상태를 관리하므로 전역 유틸은 no-op)
ToiletList searchToiletList(BuildContext context) => const [];
FutureToiletList getSearchList(BuildContext context) async => const [];
void initSearchList(BuildContext context) {}
void setSearchPage(BuildContext context, int newVal) {}
