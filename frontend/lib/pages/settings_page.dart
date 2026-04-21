import 'package:find_toilet/data/datasources/remote/settings_remote_data_source.dart';
import 'package:find_toilet/data/repositories/settings_repository_impl.dart';
import 'package:find_toilet/domain/repositories/settings_repository.dart';
import 'package:find_toilet/presentation/view_models/settings_view_model.dart';
import 'package:find_toilet/presentation/views/settings_view.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
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
      remote: SettingsRemoteDataSource(),
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
