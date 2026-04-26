// ignore_for_file: use_build_context_synchronously

import 'package:find_toilet/core/utils/global_utils.dart';
import 'package:find_toilet/core/utils/icon_image.dart';
import 'package:find_toilet/core/utils/style.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/core/widgets/button.dart';
import 'package:find_toilet/core/widgets/modal.dart';
import 'package:find_toilet/core/widgets/text_widget.dart';
import 'package:find_toilet/pages/settings/presentation/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  final bool showReview;
  final int? toiletId;
  final ReturnVoid refreshPage;

  const SettingsView({
    super.key,
    required this.showReview,
    this.toiletId,
    required this.refreshPage,
  });

  static const _menuList = [
    '확대/축소 버튼',
    '글자 크기',
    '지도 반경',
    '문의하기',
    '개인/위치 정보 처리 방침',
    '라이선스',
    '도움말',
  ];

  static const _iconList = [
    scaleIcon,
    fontIcon,
    gpsIcon,
    inquiryIcon,
    policyIcon,
    licenseIcon,
    helpIcon,
  ];

  final _pages = const [
    PolicyModal(),
    HelpModal(isHelpModal: false),
    HelpModal(),
  ];

  Future<void> _sendEmail(BuildContext context) async {
    final failureBody = await context.read<SettingsViewModel>().sendEmail();
    if (failureBody != null && context.mounted) {
      showModal(
        context,
        page: AlertModal(
          title: '문의하기',
          content: failureBody,
          onPressed: () => Clipboard.setData(ClipboardData(text: failureBody)),
        ),
      );
    }
  }

  Future<void> _loginOrLogout(BuildContext context) async {
    try {
      final token = readToken(context);
      if (token == null || token == '') {
        if (hideModal(context)) {
          final result = await context.read<SettingsViewModel>().login();
          if (!context.mounted) return;
          if (result['result'] != false) {
            changeToken(
              context,
              token: result['token'] as String?,
              refresh: result['refresh'] as String?,
            );
            if (result['state'] != 'login' || result['nickname'] == null) {
              showModal(
                context,
                page: const NicknameInputModal(isAlert: true),
              );
            } else {
              changeName(context, result['nickname'] as String?);
            }
          }
        } else {
          showModal(
            context,
            page: JoinModal(
              showReview: showReview,
              toiletId: toiletId,
              refreshPage: refreshPage,
              pageContext: context,
            ),
          );
        }
      } else {
        changeToken(context, token: null, refresh: null);
        changeName(context, null);
      }
    } catch (_) {
      if (!context.mounted) return;
      setLoading(context, false);
      showModal(
        context,
        page: const AlertModal(
          title: '오류 발생',
          content: '카카오톡 로그인 오류가 발생했습니다.',
        ),
      );
    }
  }

  String _optionTitle(BuildContext context, int i) {
    switch (i) {
      case 0:
        return watchMagnify(context);
      case 1:
        return getThemeState(context);
      default:
        return getRadius(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
        child: GestureDetector(
          onHorizontalDragEnd: (_) => routerPop(context)(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: getToken(context) != null
                          ? CustomButton(
                              textColor: CustomColors.blackColor,
                              fontSize: FontSize.smallSize,
                              onPressed: () => showModal(
                                context,
                                page: const NicknameInputModal(
                                  isAlert: false,
                                ),
                              ),
                              buttonText: '닉네임 변경',
                            )
                          : const SizedBox(),
                    ),
                    Flexible(
                      flex: 5,
                      child: GestureDetector(
                        onTap: () => _loginOrLogout(context),
                        child: getToken(context) != null
                            ? TextWithIcon(
                                icon: logoutIcon,
                                text: '로그아웃',
                                iconColor: CustomColors.blackColor,
                                fontSize: getThemeState(context) == '기본'
                                    ? FontSize.defaultSize
                                    : FontSize.largeDefaultSize,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                applyTheme: false,
                              )
                            : Image.asset(
                                kakaoLogin,
                                filterQuality: FilterQuality.high,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const Flexible(
                flex: 2,
                child: CustomText(
                  title: '어떤 것을 원하시나요?',
                  fontSize: FontSize.largeSize,
                  color: CustomColors.mainColor,
                  font: kimm,
                ),
              ),
              Flexible(
                flex: 14,
                child: Column(
                  children: [
                    for (int i = 0; i < 3; i += 1)
                      _eachMenu(
                        index: i,
                        onTap: () => changeOptions(context, i),
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        child: _option(context, i),
                      ),
                    _eachMenu(
                      index: 3,
                      onTap: () => _sendEmail(context),
                    ),
                    for (int i = 4; i < 7; i += 1)
                      _eachMenu(
                        index: i,
                        onTap: () => showModal(
                          context,
                          page: _pages[i - 4],
                        ),
                      ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getToken(context) != null
                        ? CustomButton(
                            textColor: CustomColors.blackColor,
                            fontSize: FontSize.smallSize,
                            onPressed: () => showModal(
                              context,
                              page: DeleteModal(
                                deleteMode: 2,
                                id: 0,
                                reviewContext: context,
                              ),
                            ),
                            buttonText: '회원 탈퇴',
                          )
                        : const SizedBox(),
                    ExitPage(
                      color: CustomColors.blackColor,
                      onTap: () {
                        refreshPage();
                        routerPop(context)();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _option(BuildContext context, int i) {
    return CustomText(
      title: _optionTitle(context, i),
      fontSize: FontSize.defaultSize,
      color: CustomColors.mainColor,
      font: kimm,
    );
  }

  GestureDetector _eachMenu({
    required int index,
    Widget? child,
    required ReturnVoid onTap,
    MainAxisAlignment? mainAxisAlignment,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment:
              mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextWithIcon(
                icon: _iconList[index],
                text: _menuList[index],
                iconColor: CustomColors.blackColor,
                fontSize: FontSize.defaultSize,
                font: kimm,
                flex: 15,
              ),
            ),
            child ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
