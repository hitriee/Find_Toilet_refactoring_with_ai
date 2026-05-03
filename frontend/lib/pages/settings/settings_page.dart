import 'package:find_toilet/core/config/app_config.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/mock/settings_mock_data_source.dart';
import 'package:find_toilet/datasources/remote/settings_remote_data_source.dart';
import 'package:find_toilet/pages/settings/data/settings_repository_impl.dart';
import 'package:find_toilet/pages/settings/domain/settings_repository.dart';
import 'package:find_toilet/pages/settings/presentation/settings_view.dart';
import 'package:find_toilet/pages/settings/presentation/settings_view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  final bool showReview;
  final int? toiletId;
  final ReturnVoid refreshPage;

  const SettingsPage({
    super.key,
    required this.showReview,
    this.toiletId,
    required this.refreshPage,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsRepository repository = SettingsRepositoryImpl(
      remote: kMockMode ? SettingsMockDataSource() : SettingsRemoteDataSource(),
    );

    return ChangeNotifierProvider(
      create: (_) => SettingsViewModel(repository: repository),
      child: SettingsView(
        showReview: showReview,
        toiletId: toiletId,
        refreshPage: refreshPage,
      ),
    );
  }
}
