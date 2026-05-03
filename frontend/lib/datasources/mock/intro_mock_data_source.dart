import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/repositories/intro_data_source_repository.dart';
import 'package:geolocator/geolocator.dart';

class IntroMockDataSource implements IntroDataSourceRepository {
  @override
  FutureVoid getPermission() => Geolocator.requestPermission();

  @override
  Future<Position> getPosition({required LocationAccuracy locationAccuracy}) =>
      Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

  @override
  FutureVoid autoLogin() {
    Future.delayed(const Duration(milliseconds: 500));
    return Future(() => true);
  }
}
