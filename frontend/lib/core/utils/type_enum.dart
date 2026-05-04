import 'package:find_toilet/core/domain/toilet_model.dart';
import 'package:find_toilet/pages/bookmark/domain/bookmark_model.dart';
import 'package:find_toilet/pages/review_form/domain/review_model.dart';
import 'package:flutter/material.dart';

//* types
typedef WidgetList = List<Widget>;
typedef StringList = List<String>;
typedef IntList = List<int>;
typedef BoolList = List<bool>;
typedef IconDataList = List<IconData>;
typedef ReturnVoid = void Function();
typedef VoidFuncList = List<ReturnVoid>;
typedef ShadowList = List<BoxShadow>;

//* model type
typedef DynamicMap = Map<String, dynamic>;
typedef DynamicMapList = List<DynamicMap>;
typedef StringMap = Map<String, String>;
typedef FutureList = Future<List>;
typedef FutureVoid = Future<void>;
typedef FutureBool = Future<bool>;
typedef FutureDynamicMap = Future<DynamicMap>;

typedef ReviewList = List<ReviewModel>;
typedef FolderList = List<FolderModel>;
typedef ToiletList = List<ToiletModel>;
typedef FutureToiletList = Future<ToiletList>;
typedef FutureReviewList = Future<ReviewList>;

enum Space { empty, one }

String convertedSpace(Space space) => space == Space.empty ? '' : ' ';
