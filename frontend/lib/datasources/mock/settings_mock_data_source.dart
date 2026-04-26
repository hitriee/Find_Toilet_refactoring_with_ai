import 'package:find_toilet/core/utils/type_enum.dart';

/// 백엔드·카카오 SDK 없이 Settings 화면을 확인하기 위한 더미 데이터 소스.
///
/// - [login] : mock_review_db / mock_toilet_db 전반에 걸쳐 사용하는
///   '테스트유저' 계정과 일관된 사용자 정보를 반환합니다.
/// - [buildEmailBody] : device_info_plus / package_info_plus 없이
///   하드코딩된 샘플 기기 정보 문자열을 반환합니다.
/// - [sendEmail] : 실제 이메일을 전송하지 않고 no-op으로 처리합니다.
class SettingsMockDataSource {
  FutureDynamicMap login() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      'token': 'mock_access_token_abc123',
      'refresh': 'mock_refresh_token_xyz789',
      'state': 'login',
      'nickname': '테스트유저',
    };
  }

  Future<String> buildEmailBody() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return '''
안녕하세요, 화장실을 찾아서 개발팀입니다.\n
저희 서비스에 관심을 보내주셔서 감사합니다.\n
아래 양식에 맞추어 문의사항을 작성해 주시면 빠르게 검토하여 답변 드리겠습니다.\n
카테고리 : 오류 / 기능 제안 / 기타\n
답변 받으실 이메일 : \n
문의 내용 : \n
OS 버전: Android 13 (SDK 33)
사용 기종 : Google Pixel 7 panther \n
사용 버전 : 1.0.0 \n

화장실을 찾아서 개발팀 (team.4ilet@gmail.com)
''';
  }

  Future<void> sendEmail(String emailBody) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Mock: 실제 이메일을 전송하지 않습니다.
  }
}
