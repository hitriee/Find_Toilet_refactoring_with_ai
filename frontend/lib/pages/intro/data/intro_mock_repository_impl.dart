import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/pages/intro/domain/intro_repository.dart';
import 'package:geolocator/geolocator.dart';

class IntroMockRepositoryImpl implements IntroRepository {
  @override
  FutureVoid getPermission() => Geolocator.requestPermission();

  @override
  Future<Position> getPosition({required LocationAccuracy locationAccuracy}) =>
      Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

  @override
  FutureVoid autoLogin() {
    Future.delayed(Duration(milliseconds: 500));
    return Future(() => true);
  }
}
