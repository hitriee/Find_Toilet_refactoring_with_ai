import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:geolocator/geolocator.dart';

abstract class IntroRepository {
  FutureVoid getPermission();

  Future<Position> getPosition({required LocationAccuracy locationAccuracy});

  FutureVoid autoLogin();
}
