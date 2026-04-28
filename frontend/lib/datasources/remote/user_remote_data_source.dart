import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/core/utils/type_enum.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

/// 카카오 OAuth 로그인 및 회원 관련 DataSource.
///
/// - 카카오 SDK에 직접 의존하므로 Mock DataSource를 별도로 만들지 않습니다.
/// - 로그인 관련 상위 흐름은 [SettingsRemoteDataSource] / [IntroRemoteDataSource]가 담당합니다.
class UserRemoteDataSource extends ApiProvider {
  FutureDynamicMap login() => _login();

  FutureDynamicMap autoLogin() async {
    try {
      if (token != null && token != '') {
        return _sendOldToken(token!);
      }
      throw Exception('저장된 토큰이 없습니다.');
    } catch (error) {
      throw Exception('자동 로그인 실패: $error');
    }
  }

  FutureBool deleteUser() => _deleteUser();

  FutureDynamicMap changeName(String newName) => _changeName(newName);

  // ── private ───────────────────────────────────────────────────────────────

  DynamicMap _returnTokens(dynamic response) {
    final headers = response.headers;
    final data = response.data;
    return {
      'token': headers['Authorization']!.first,
      'refresh': headers['Authorization-refresh']!.first,
      'state': data['state'],
      'nickname': data['data']['nickname'],
    };
  }

  FutureDynamicMap _sendOldToken(String token) async {
    try {
      await dioWithToken(url: userInfoUrl, method: 'GET').get(userInfoUrl);
      return {};
    } catch (error) {
      throw Exception('기존 토큰 검증 실패: $error');
    }
  }

  FutureDynamicMap _sendToken(String token) async {
    try {
      final response = await dioWithToken(url: loginUrl, method: 'POST')
          .post(loginUrl, data: {'token': token});
      return _returnTokens(response);
    } catch (error) {
      throw Exception('카카오 토큰 서버 전송 실패: $error');
    }
  }

  FutureDynamicMap _kakaoLogin(bool withKakaoTalk) async {
    try {
      final OAuthToken kakaoResponse = withKakaoTalk
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      return _sendToken(kakaoResponse.accessToken);
    } catch (error) {
      if (error is PlatformException && error.code == 'CANCELED') {
        return {'result': false};
      } else if (error is KakaoAuthException) {
        return {'result': false};
      }
      debugPrint('카카오 로그인 오류: $error (${error.runtimeType})');
      throw Exception('카카오 로그인 중 예상치 못한 오류: $error');
    }
  }

  FutureDynamicMap _login() async {
    if (await isKakaoTalkInstalled()) {
      try {
        return _kakaoLogin(true);
      } catch (_) {
        return _kakaoLogin(false);
      }
    }
    return _kakaoLogin(false);
  }

  FutureBool _deleteUser() async {
    try {
      await deleteApi(deleteUserUrl);
      return true;
    } catch (error) {
      throw Exception('회원 탈퇴 실패: $error');
    }
  }

  FutureDynamicMap _changeName(String newName) async {
    try {
      return await updateApi(changeNameUrl, data: {'nickname': newName});
    } catch (error) {
      throw Exception('닉네임 변경 실패: $error');
    }
  }
}
