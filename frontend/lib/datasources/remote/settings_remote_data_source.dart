import 'package:find_toilet/datasources/remote/user_remote_data_source.dart';
import 'package:find_toilet/core/utils/settings_utils.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SettingsRemoteDataSource {
  FutureDynamicMap login() => UserRemoteDataSource().login();

  Future<String> buildEmailBody() => body();

  Future<void> sendEmail(String emailBody) async {
    final email = Email(
      subject: '[화장실을 찾아서] 문의사항',
      recipients: ['team.4ilet@gmail.com'],
      body: emailBody,
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}
