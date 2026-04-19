import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:geolocator/geolocator.dart';

abstract class IntroRepository {
  FutureVoid getPermission();

  Future<Position> getPosition({required LocationAccuracy locationAccuracy});
}
