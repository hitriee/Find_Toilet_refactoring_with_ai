//* 토큰 받아오기
import 'package:find_toilet/core/config/state_provider.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/core/widgets/modal.dart';
import 'package:find_toilet/datasources/remote/user_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String? readToken(BuildContext context) =>
    context.read<UserInfoProvider>().token;

String? getToken(BuildContext context) =>
    context.watch<UserInfoProvider>().token;

//* 토큰 변경
void changeToken(BuildContext context, {String? token, String? refresh}) {
  final userInfo = context.read<UserInfoProvider>();
  userInfo.setStoreToken(token);
  userInfo.setStoreRefresh(refresh);
}

//* 닉네임
void changeName(BuildContext context, String? name) =>
    context.read<UserInfoProvider>().setStoreName(name);

String? getName(BuildContext context) =>
    context.read<UserInfoProvider>().nickname;

//* 로그인
FutureDynamicMap login(BuildContext context) async {
  final DynamicMap result = await UserRemoteDataSource().login();
  if (result['result'] != false) {
    // ignore: use_build_context_synchronously
    changeToken(context, token: result['token'], refresh: result['refresh']);
    if (result['state'] != 'login' || result['nickname'] == null) {
      // ignore: use_build_context_synchronously
      showDialog<bool>(
        barrierDismissible: false,
        context: context,
        builder: (context) => const NicknameInputModal(isAlert: true),
      );
    } else {
      // ignore: use_build_context_synchronously
      changeName(context, result['nickname']);
    }
    return result;
  }
  return {};
}
