import 'package:find_toilet/datasources/remote/intro_remote_data_source.dart';
import 'package:find_toilet/pages/intro/domain/intro_repository.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:geolocator/geolocator.dart';

class IntroRepositoryImpl extends IntroRepository {
  final IntroRemoteDataSource remote;

  IntroRepositoryImpl({required this.remote});

  @override
  FutureVoid getPermission() async {
    try {
      return await remote.getPermission();
    } catch (error) {
      throw Exception('위치 권한 요청에 실패했습니다: $error');
    }
  }

  @override
  Future<Position> getPosition(
      {required LocationAccuracy locationAccuracy}) async {
    try {
      return await remote.getPosition(locationAccuracy: locationAccuracy);
    } catch (error) {
      throw Exception('현재 위치를 가져오는 데 실패했습니다: $error');
    }
  }

  @override
  FutureVoid autoLogin() async {
    try {
      return await remote.autoLogin();
    } catch (error) {
      throw Exception('자동 로그인에 실패했습니다: $error');
    }
  }
}
