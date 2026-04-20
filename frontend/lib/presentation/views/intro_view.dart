// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:find_toilet/presentation/view_models/state_provider.dart';
import 'package:find_toilet/presentation/view_models/intro_view_model.dart';
import 'package:find_toilet/presentation/views/main_view.dart';
import 'package:find_toilet/pages/select_theme_page.dart';
import 'package:find_toilet/shared/utils/global_utils.dart';
import 'package:find_toilet/shared/utils/icon_image.dart';
import 'package:find_toilet/shared/utils/style.dart';
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
              : const Main(),
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
