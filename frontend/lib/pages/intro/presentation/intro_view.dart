// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:find_toilet/core/theme/style.dart';
import 'package:find_toilet/pages/settings/presentation/settings_view_model.dart';
import 'package:find_toilet/pages/intro/presentation/intro_view_model.dart';
import 'package:find_toilet/pages/main/main_page.dart';
import 'package:find_toilet/pages/select_theme/select_theme_page.dart';
import 'package:find_toilet/core/utils/global_utils.dart';
import 'package:find_toilet/core/utils/icon_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsProvider>().initSettings();
    context.read<IntroViewModel>().userLocation().then((position) {
      setLatLng(context, position.latitude, position.longitude);
      Future.delayed(const Duration(seconds: 2), () {
        setRadius(context);
        removedRouterPush(
          context,
          page: getFontSize(context) == null
              ? const SelectThemePage()
              : const MainPage(),
        );
      });
    }).catchError((_) {
      SystemNavigator.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
          child: Image.asset(
        logo,
        filterQuality: FilterQuality.high,
      )),
    );
  }
}
