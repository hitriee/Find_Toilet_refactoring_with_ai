// ignore_for_file: use_build_context_synchronously

import 'package:find_toilet/presentation/view_models/select_theme_view_model.dart';
import 'package:find_toilet/presentation/view_models/state_provider.dart';
import 'package:find_toilet/presentation/views/main_view.dart';
import 'package:find_toilet/shared/utils/global_utils.dart';
import 'package:find_toilet/shared/utils/style.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:find_toilet/shared/widgets/box_container.dart';
import 'package:find_toilet/shared/widgets/button.dart';
import 'package:find_toilet/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectThemeView extends StatelessWidget {
  const SelectThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitApp(context),
      child: Scaffold(
        backgroundColor: mainColor,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Center(
                    child: Column(
                      children: [
                        CustomText(
                          title: '어서오세요!',
                          fontSize: FontSize.titleSize,
                          color: CustomColors.whiteColor,
                          font: kimm,
                          applyTheme: false,
                        ),
                        SizedBox(height: 10),
                        CustomText(
                          title: '사용하실 테마를 선택해주세요.',
                          color: CustomColors.whiteColor,
                          applyTheme: false,
                        ),
                      ],
                    ),
                  ),
                  Consumer<SelectThemeViewModel>(
                    builder: (_, vm, __) => ThemeBox(
                      text: '큰 글씨',
                      selected: vm.isLargeFont,
                      fontSize: FontSize.largeSize,
                      onTap: () => vm.changeFontSize(true),
                      isLarge: true,
                    ),
                  ),
                  Consumer<SelectThemeViewModel>(
                    builder: (_, vm, __) => ThemeBox(
                      text: '기본',
                      selected: !vm.isLargeFont,
                      onTap: () => vm.changeFontSize(false),
                      isLarge: false,
                    ),
                  ),
                  CustomButton(
                    onPressed: () {
                      final vm = context.read<SelectThemeViewModel>();
                      vm.applyTheme().then((_) {
                        context
                            .read<SettingsProvider>()
                            .initOption(vm.isLargeFont);
                        removedRouterPush(context, page: const Main());
                      });
                    },
                  ),
                ],
              ),
            ),
            watchPressed(context)
                ? const Center(
                    child: CustomBox(
                      height: 60,
                      width: 300,
                      color: whiteColor,
                      child: CustomText(
                        title: '뒤로 가기 버튼을 한 번 더 누르시면 앱이 종료됩니다',
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
