import 'package:find_toilet/core/network/user_provider.dart';
import 'package:find_toilet/data/datasources/remote/settings_remote_data_source.dart';
import 'package:find_toilet/shared/utils/settings_utils.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mocktail/mocktail.dart';

class MockSettings extends Mock implements SettingsRemoteDataSource {}
