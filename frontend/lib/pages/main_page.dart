import 'package:find_toilet/data/datasources/remote/toilet_remote_data_source.dart';
import 'package:find_toilet/data/repositories/toilet_repository_impl.dart';
import 'package:find_toilet/domain/repositories/toilet_repository.dart';
import 'package:find_toilet/presentation/view_models/main_view_model.dart';
import 'package:find_toilet/presentation/views/main_view.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
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
    final ToiletRepository repository = ToiletRepositoryImpl(
      remote: ToiletRemoteDataSource(),
    );

    return ChangeNotifierProvider(
      create: (_) => MainViewModel(repository: repository),
      child: MainView(
        showReview: showReview,
        refreshPage: refreshPage,
        needNear: needNear,
        beforePage: beforePage,
      ),
    );
  }
}
