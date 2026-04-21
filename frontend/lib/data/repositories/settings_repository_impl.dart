import 'package:find_toilet/data/datasources/remote/settings_remote_data_source.dart';
import 'package:find_toilet/domain/repositories/settings_repository.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDataSource remote;

  SettingsRepositoryImpl({required this.remote});

  @override
  FutureDynamicMap login() async {
    try {
      return await remote.login();
    } catch (e) {
      throw Exception('카카오 로그인에 실패했습니다.');
    }
  }

  @override
  Future<String> buildEmailBody() async {
    try {
      return await remote.buildEmailBody();
    } catch (e) {
      throw Exception('기기 정보를 불러오는 데 실패했습니다.');
    }
  }

  @override
  Future<void> sendEmail(String emailBody) async {
    try {
      await remote.sendEmail(emailBody);
    } catch (e) {
      throw Exception('이메일 전송에 실패했습니다.');
    }
  }
}
