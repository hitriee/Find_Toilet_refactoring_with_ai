import 'package:find_toilet/data/datasources/mock/settings_mock_data_source.dart';
import 'package:find_toilet/domain/repositories/settings_repository.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

class SettingsMockRepositoryImpl implements SettingsRepository {
  final _dataSource = SettingsMockDataSource();

  @override
  FutureDynamicMap login() => _dataSource.login();

  @override
  Future<String> buildEmailBody() => _dataSource.buildEmailBody();

  @override
  Future<void> sendEmail(String emailBody) => _dataSource.sendEmail(emailBody);
}
