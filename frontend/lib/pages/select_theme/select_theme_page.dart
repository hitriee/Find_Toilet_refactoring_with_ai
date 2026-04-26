import 'package:find_toilet/datasources/local/select_theme_local_data_source.dart';
import 'package:find_toilet/pages/select_theme/data/select_theme_repository_impl.dart';
import 'package:find_toilet/pages/select_theme/domain/select_theme_repository.dart';
import 'package:find_toilet/pages/select_theme/presentation/select_theme_view.dart';
import 'package:find_toilet/pages/select_theme/presentation/select_theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectThemePage extends StatelessWidget {
  const SelectThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectThemeRepository repository = SelectThemeRepositoryImpl(
      remote: SelectThemeLocalDataSource(),
    );

    return ChangeNotifierProvider(
      create: (_) => SelectThemeViewModel(repository: repository),
      child: const SelectThemeView(),
    );
  }
}
