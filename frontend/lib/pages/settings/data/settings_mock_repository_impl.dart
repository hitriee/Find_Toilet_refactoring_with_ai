import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/mock/settings_mock_data_source.dart';
import 'package:find_toilet/pages/settings/domain/settings_repository.dart';

class SettingsMockRepositoryImpl implements SettingsRepository {
  final _dataSource = SettingsMockDataSource();

  @override
  FutureDynamicMap login() => _dataSource.login();

  @override
  Future<String> buildEmailBody() => _dataSource.buildEmailBody();

  @override
  Future<void> sendEmail(String emailBody) => _dataSource.sendEmail(emailBody);
}
