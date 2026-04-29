//* 함수

//* 화면 이동 (뒤로 가기 적용 X)
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:flutter/material.dart';

Future<bool?> removedRouterPush(BuildContext context, {required Widget page}) =>
    Navigator.pushAndRemoveUntil<bool>(
      context,
      MaterialPageRoute(builder: (context) => page),
      (router) => false,
    );

//* 화면 이동
Future<bool?> Function() routerPush(BuildContext context,
    {required Widget page, ReturnVoid? afterPush}) {
  return () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page))
        .then((value) {
      if (afterPush != null) {
        afterPush();
      }
    });
    return Future.value(false);
  };
}

//* 나가기, 뒤로 가기
ReturnVoid routerPop(BuildContext context) {
  return () => Navigator.pop<Future<bool?>>(context);
}

//* 모달 띄우기
Future<bool?> showModal(BuildContext context, {required Widget page}) =>
    showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => page,
    );

//* 너비, 높이
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double statusBarHeight(BuildContext context) =>
    MediaQuery.of(context).padding.top;
