import 'package:find_toilet/core/config/app_config.dart';
import 'package:find_toilet/core/config/state_provider.dart';
import 'package:find_toilet/core/domain/toilet_model.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/mock/review_form_mock_data_source.dart';
import 'package:find_toilet/datasources/remote/review_form_remote_data_source.dart';
import 'package:find_toilet/datasources/repositories/review_form_data_source_repository.dart';
import 'package:find_toilet/pages/main/presentation/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* review list
void addReviewList(BuildContext context, ReviewList reviewData) =>
    context.read<MainViewModel>().addReviewList(reviewData);

ReviewList reviewList(BuildContext context) =>
    context.read<MainViewModel>().reviewList;

ToiletModel? getToilet(BuildContext context) =>
    context.read<ToiletProvider>().toiletInfo;

void setToilet(BuildContext context, ToiletModel toiletModel) =>
    context.read<ToiletProvider>().setToiletInfo(toiletModel);

double? getItemHeight(BuildContext context) =>
    context.read<ToiletProvider>().itemHeight;

void setItemHeight(BuildContext context, int i) =>
    context.read<ToiletProvider>().setItemHeight(i);

int? getToiletId(BuildContext context) =>
    context.read<ToiletProvider>().toiletId;

FutureReviewList getReviewList(BuildContext context) async {
  final toiletId = ToiletProvider().toiletId!;
  final ReviewFormDataSourceRepository dataSource =
      kMockMode ? ReviewFormMockDataSource() : ReviewFormRemoteDataSource();
  final reviewData =
      await dataSource.getReviewList(toiletId, ScrollProvider().page);
  addReviewList(context, reviewData);
  return reviewData;
}

void initReviewList(BuildContext context) =>
    context.read<MainViewModel>().initReviewList();

double? getHeight(BuildContext context, int i) =>
    context.read<ToiletProvider>().heightList.length > i
        ? context.read<ToiletProvider>().heightList[i]
        : null;

void setHeightListSize(BuildContext context) =>
    context.read<ToiletProvider>().setHeightListSize();

void setHeight(BuildContext context, int i, double newHeight) =>
    context.read<ToiletProvider>().setHeight(i, newHeight);

void initHeightList(BuildContext context) =>
    context.read<ToiletProvider>().initHeightList();
