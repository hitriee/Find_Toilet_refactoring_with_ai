import 'package:flutter/foundation.dart';
import 'package:find_toilet/core/network/user_provider.dart';
import 'package:find_toilet/presentation/view_models/state_provider.dart';

/// Intro screen 비즈니스 로직(자동 로그인/토큰 초기화)을 ViewModel로 이동합니다.
class IntroViewModel extends ChangeNotifier {
  final UserInfoProvider userInfoProvider;

  IntroViewModel({required this.userInfoProvider});

  Future<void> preparation() async {
    await userInfoProvider.initVar();
    try {
      // 자동 로그인 시도. 실패하면 토큰/리프레시를 비웁니다.
      await UserProvider().autoLogin();
    } catch (_) {
      userInfoProvider.setStoreToken(null);
      userInfoProvider.setStoreRefresh(null);
    }
  }
}

