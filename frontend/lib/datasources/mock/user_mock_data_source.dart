import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/repositories/user_data_source_repository.dart';

/// Mock 로그인 DataSource.
/// kMockMode=true 시 카카오 SDK 없이 더미 토큰·닉네임을 반환합니다.
class UserMockDataSource implements UserDataSourceRepository {
  @override
  FutureDynamicMap login() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      'token': 'mock_token',
      'refresh': 'mock_refresh',
      'state': 'login',
      'nickname': 'Mock User',
    };
  }

  @override
  FutureDynamicMap changeName(String newName) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {'success': newName};
  }
}
