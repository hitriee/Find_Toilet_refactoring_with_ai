import 'package:find_toilet/datasources/remote/user_remote_data_source.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:geolocator/geolocator.dart';

class IntroRemoteDataSource {
  FutureVoid getPermission() => Geolocator.requestPermission();

  Future<Position> getPosition({required LocationAccuracy locationAccuracy}) =>
      Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

  FutureVoid autoLogin() => UserRemoteDataSource().autoLogin();
}
