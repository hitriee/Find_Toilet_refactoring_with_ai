import 'package:find_toilet/core/config/app_config.dart';
import 'package:find_toilet/core/data/toilet_mock_repository_impl.dart';
import 'package:find_toilet/core/data/toilet_repository_impl.dart';
import 'package:find_toilet/core/domain/toilet_repository.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/remote/toilet_remote_data_source.dart';
import 'package:find_toilet/pages/main/presentation/main_view.dart';
import 'package:find_toilet/pages/main/presentation/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  final bool showReview, needNear;
  final ReturnVoid? refreshPage;
  final String? beforePage;

  const MainPage({
    super.key,
    this.showReview = false,
    this.refreshPage,
    this.needNear = true,
    this.beforePage,
  });

  @override
  Widget build(BuildContext context) {
    final ToiletRepository repository = kMockMode
        ? ToiletMockRepositoryImpl()
        : ToiletRepositoryImpl(remote: ToiletRemoteDataSource());

    return ChangeNotifierProvider(
      create: (_) => MainViewModel(repository: repository)..loadInitial(showReview),
      child: MainView(
        showReview: showReview,
        refreshPage: refreshPage,
        needNear: needNear,
        beforePage: beforePage,
      ),
    );
  }
}
