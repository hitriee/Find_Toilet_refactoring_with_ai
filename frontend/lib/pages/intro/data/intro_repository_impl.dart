import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/repositories/intro_data_source_repository.dart';
import 'package:find_toilet/pages/intro/domain/intro_repository.dart';
import 'package:geolocator/geolocator.dart';

class IntroRepositoryImpl extends IntroRepository {
  final IntroDataSourceRepository remote;

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
  Future<Position> getPosition() async {
    try {
      return await remote.getPosition();
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
