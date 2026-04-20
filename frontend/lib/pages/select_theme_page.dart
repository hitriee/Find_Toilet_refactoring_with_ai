import 'package:find_toilet/data/datasources/remote/select_theme_remote_data_source.dart';
import 'package:find_toilet/data/repositories/select_theme_repository_impl.dart';
import 'package:find_toilet/domain/repositories/select_theme_repository.dart';
import 'package:find_toilet/presentation/view_models/select_theme_view_model.dart';
import 'package:find_toilet/presentation/views/select_theme_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectThemePage extends StatelessWidget {
  const SelectThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectThemeRepository repository = SelectThemeRepositoryImpl(
      remote: SelectThemeRemoteDataSource(),
    );

    return ChangeNotifierProvider(
      create: (_) => SelectThemeViewModel(repository: repository),
      child: const SelectThemeView(),
    );
  }
}
