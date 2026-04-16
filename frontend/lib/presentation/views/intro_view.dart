// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:find_toilet/presentation/view_models/state_provider.dart';
import 'package:find_toilet/presentation/view_models/intro_view_model.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/screens/select_theme_screen.dart';
import 'package:find_toilet/shared/utils/global_utils.dart';
import 'package:find_toilet/shared/utils/icon_image.dart';
import 'package:find_toilet/shared/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  late final IntroViewModel _viewModel;

  Future<Position> userLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setLatLng(context, position.latitude, position.longitude);
      return position;
    } catch (error) {
      throw Error();
    }
  }

  @override
  void initState() {
    super.initState();

    _viewModel = IntroViewModel(
      userInfoProvider: context.read<UserInfoProvider>(),
    );
    _viewModel.preparation();

    context.read<SettingsProvider>().initSettings();
    userLocation().then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        setRadius(context);
        removedRouterPush(
          context,
          page: getFontSize(context) == null
              ? const SelectFontTheme()
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
