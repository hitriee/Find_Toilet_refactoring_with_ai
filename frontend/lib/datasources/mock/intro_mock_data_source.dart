import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/repositories/intro_data_source_repository.dart';
import 'package:geolocator/geolocator.dart';

/// Mock 위치 기준점: 서울역 공중화장실 (MockToiletDb 첫 번째 항목)
/// lat: 37.5547, lon: 126.9707
class IntroMockDataSource implements IntroDataSourceRepository {
  @override
  FutureVoid getPermission() async {}

  @override
  Future<Position> getPosition(
      {required LocationAccuracy locationAccuracy}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Position(
      latitude: 37.5547,
      longitude: 126.9707,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
  }

  @override
  FutureVoid autoLogin() {
    Future.delayed(const Duration(milliseconds: 500));
    return Future(() => true);
  }
}
