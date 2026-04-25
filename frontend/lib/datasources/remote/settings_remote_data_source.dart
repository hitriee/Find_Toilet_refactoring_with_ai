import 'package:find_toilet/core/network/user_provider.dart';
import 'package:find_toilet/shared/utils/settings_utils.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SettingsRemoteDataSource {
  FutureDynamicMap login() => UserProvider().login();

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
