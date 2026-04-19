import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:geolocator/geolocator.dart';

class IntroRemoteDataSource extends ApiProvider {
  FutureVoid getPermission() => Geolocator.requestPermission();

  Future<Position> getPosition({required LocationAccuracy locationAccuracy}) =>
      Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
}
