import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/remote/user_remote_data_source.dart';
import 'package:find_toilet/datasources/repositories/intro_data_source_repository.dart';
import 'package:geolocator/geolocator.dart';

class IntroRemoteDataSource implements IntroDataSourceRepository {
  FutureVoid getPermission() => Geolocator.requestPermission();

  Future<Position> getPosition({required LocationAccuracy locationAccuracy}) =>
      Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

  FutureVoid autoLogin() => UserRemoteDataSource().autoLogin();
}
