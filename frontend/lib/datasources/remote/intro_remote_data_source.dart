import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/remote/user_remote_data_source.dart';
import 'package:find_toilet/datasources/repositories/intro_data_source_repository.dart';
import 'package:geolocator/geolocator.dart';

class IntroRemoteDataSource implements IntroDataSourceRepository {
  @override
  FutureVoid getPermission() => Geolocator.requestPermission();

  @override
  Future<Position> getPosition() => Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

  @override
  FutureVoid autoLogin() => UserRemoteDataSource().autoLogin();
}
