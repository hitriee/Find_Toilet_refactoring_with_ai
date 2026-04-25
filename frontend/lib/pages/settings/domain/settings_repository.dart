import 'package:find_toilet/shared/utils/type_enum.dart';

abstract class SettingsRepository {
  FutureDynamicMap login();

  Future<String> buildEmailBody();

  Future<void> sendEmail(String emailBody);
}
