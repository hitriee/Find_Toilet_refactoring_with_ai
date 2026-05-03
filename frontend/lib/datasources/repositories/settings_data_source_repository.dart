import 'package:find_toilet/core/utils/type_enum.dart';

abstract class SettingsDataSourceRepository {
  FutureDynamicMap login();
  Future<String> buildEmailBody();
  Future<void> sendEmail(String emailBody);
}
