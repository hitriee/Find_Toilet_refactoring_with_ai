import 'package:find_toilet/domain/repositories/intro_repository.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:find_toilet/core/network/user_provider.dart';
import 'package:find_toilet/presentation/view_models/state_provider.dart';
import 'package:geolocator/geolocator.dart';

/// Intro screen 비즈니스 로직(자동 로그인/토큰 초기화)을 ViewModel로 이동합니다.
class IntroViewModel extends ChangeNotifier {
  final IntroRepository _introRepository;
  IntroViewModel({required IntroRepository introRepository})
      : _introRepository = introRepository;

  FutureVoid loadInitial() async {
    final userInfoProvider = UserInfoProvider();
    await userInfoProvider.initVar();
    try {
      // 자동 로그인 시도. 실패하면 토큰/리프레시를 비웁니다.
      await UserProvider().autoLogin();
    } catch (_) {
      userInfoProvider.setStoreToken(null);
      userInfoProvider.setStoreRefresh(null);
    }
  }

  Future<Position> userLocation() async {
    try {
      await _introRepository.getPermission();
      Position position = await _introRepository.getPosition(
          locationAccuracy: LocationAccuracy.high);
      return position;
    } catch (error) {
      throw Error();
    }
  }
}
