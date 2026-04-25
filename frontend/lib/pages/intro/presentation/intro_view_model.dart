import 'package:find_toilet/pages/intro/domain/intro_repository.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/core/config/state_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class IntroViewModel extends ChangeNotifier {
  final IntroRepository _introRepository;

  IntroViewModel({required IntroRepository introRepository})
      : _introRepository = introRepository;

  FutureVoid loadInitial() async {
    final userInfoProvider = UserInfoProvider();
    await userInfoProvider.initVar();
    try {
      await _introRepository.autoLogin();
    } catch (_) {
      userInfoProvider.setStoreToken(null);
      userInfoProvider.setStoreRefresh(null);
    }
  }

  Future<Position> userLocation() async {
    try {
      await _introRepository.getPermission();
      return await _introRepository.getPosition(
        locationAccuracy: LocationAccuracy.high,
      );
    } catch (error) {
      throw Exception('위치 정보를 가져오는 데 실패했습니다: $error');
    }
  }
}
