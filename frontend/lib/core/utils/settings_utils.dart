import 'package:find_toilet/core/config/state_provider.dart';
import 'package:find_toilet/core/theme/style.dart';
import 'package:find_toilet/pages/settings/presentation/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* 현재 글자 크기
String? getFontSize(BuildContext context) =>
    context.read<SettingsProvider>().fontState;

bool isDefaultTheme(BuildContext context) =>
    context.watch<SettingsProvider>().fontState == '기본';

String getThemeState(BuildContext context) =>
    context.watch<SettingsProvider>().fontState;

FontSize applyDefaultTheme(BuildContext context, FontSize defaultFont) {
  if (isDefaultTheme(context)) {
    return defaultFont;
  } else {
    switch (defaultFont) {
      case FontSize.titleSize:
        return FontSize.largeTitleSize;
      case FontSize.largeSize:
        return FontSize.largeLargeSize;
      case FontSize.defaultSize:
        return FontSize.largeDefaultSize;
      default:
        return FontSize.largeSmallSize;
    }
  }
}

//* 화면 확대/축소 버튼
String watchMagnify(BuildContext context) =>
    context.watch<SettingsProvider>().magnigyState;

//* 지도 반경
String getRadius(BuildContext context) =>
    context.watch<SettingsProvider>().radiusState;

int getIntRadius(BuildContext context) =>
    context.read<SettingsProvider>().radius;

//* 메뉴 옵션 변경
void changeOptions(BuildContext context, int menuIdx) {
  context.read<SettingsProvider>().applyOption(menuIdx);
  if (menuIdx == 1) {
    context
        .read<MapStateProvider>()
        .setRadius(context.read<SettingsProvider>().radius);
  }
}

//* 뒤로 가기 버튼 눌렀을 경우 (메인, 테마 선택)
bool exitApp(BuildContext context) =>
    context.read<ApplyChangeProvider>().changePressed();

//* 뒤로 가기 버튼 눌림 여부
bool watchPressed(BuildContext context) =>
    context.watch<ApplyChangeProvider>().pressedOnce;

//* 새로고침 확인
String onRefresh(BuildContext context) =>
    context.watch<ApplyChangeProvider>().refresh.trim();

//* 새로고침
void changeRefresh(BuildContext context) =>
    context.read<ApplyChangeProvider>().refreshPage();

//* 회원가입 모달
bool hideModal(BuildContext context) =>
    context.read<SettingsProvider>().hideModal;

void setJoin(BuildContext context) =>
    context.read<SettingsProvider>().setJoin();
