import 'package:find_toilet/datasources/remote/intro_remote_data_source.dart';
import 'package:find_toilet/pages/intro/data/intro_repository_impl.dart';
import 'package:find_toilet/pages/intro/domain/intro_repository.dart';
import 'package:find_toilet/pages/intro/presentation/intro_view_model.dart';
import 'package:find_toilet/pages/intro/presentation/intro_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final IntroRepository introRepository = IntroRepositoryImpl(
      remote: IntroRemoteDataSource(),
    );

    return ChangeNotifierProvider(
      create: (_) => IntroViewModel(
        introRepository: introRepository,
      )..loadInitial(),
      child: const IntroView(),
    );
  }
}
