import 'package:flutter/material.dart';

//* 색 관련
const mainColor = Color(0xFF5957D4);
const whiteColor = Colors.white;
const blackColor = Colors.black;
const redColor = Colors.red;
const yellowColor = Color(0xFFFFBF44);
const greyColor = Colors.grey;
const lightGreyColor = Color(0xFFE5E5E5);
const lightBlueColor = Colors.lightBlue;

enum CustomColors {
  whiteColor,
  mainColor,
  redColor,
  blackColor,
  yellowColor,
  lightBlueColor,
}

//* enum to Color, double, int, ...
Color convertedColor(CustomColors color) {
  switch (color) {
    case CustomColors.whiteColor:
      return whiteColor;
    case CustomColors.mainColor:
      return mainColor;
    case CustomColors.blackColor:
      return blackColor;
    case CustomColors.redColor:
      return redColor;
    case CustomColors.yellowColor:
      return yellowColor;
    default:
      return lightBlueColor;
  }
}

//* 글씨 크기 관련
const double largeTitleSize = 34;
const double titleSize = 31;
const double largeLargeSize = 28;
const double largeSize = 25;
const double largeDefaultSize = 22;
const double defaultSize = 19;
const double largeSmallSize = 17;
const double smallSize = 14;

enum FontSize {
  largeTitleSize,
  titleSize,
  largeLargeSize,
  largeSize,
  largeDefaultSize,
  defaultSize,
  largeSmallSize,
  smallSize,
}

double convertedSize(FontSize size) {
  switch (size) {
    case FontSize.largeTitleSize:
      return largeTitleSize;
    case FontSize.titleSize:
      return titleSize;
    case FontSize.largeLargeSize:
      return largeLargeSize;
    case FontSize.largeSize:
      return largeSize;
    case FontSize.largeSmallSize:
      return largeSmallSize;
    case FontSize.smallSize:
      return smallSize;
    case FontSize.largeDefaultSize:
      return largeDefaultSize;
    default:
      return defaultSize;
  }
}

//* 그림자
const defaultShadow = BoxShadow(
  color: greyColor,
  blurRadius: 1,
  spreadRadius: 0.1,
  offset: Offset(0, 1),
);

const highlightShadow = BoxShadow(
  color: mainColor,
  blurRadius: 3,
  spreadRadius: 3,
);

const redShadow = BoxShadow(blurRadius: 10, spreadRadius: 5, color: Colors.red);

//* 글씨체 관련
const kimm = 'Kimm';
