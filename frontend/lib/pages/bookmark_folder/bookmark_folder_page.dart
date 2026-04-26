import 'package:find_toilet/core/config/app_config.dart';
import 'package:find_toilet/datasources/remote/bookmark_folder_remote_data_source.dart';
import 'package:find_toilet/pages/bookmark_folder/data/bookmark_folder_mock_repository_impl.dart';
import 'package:find_toilet/pages/bookmark_folder/data/bookmark_folder_repository_impl.dart';
import 'package:find_toilet/pages/bookmark_folder/domain/bookmark_folder_repository.dart';
import 'package:find_toilet/pages/bookmark_folder/presentation/bookmark_folder_view.dart';
import 'package:find_toilet/pages/bookmark_folder/presentation/bookmark_folder_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkFolderPage extends StatelessWidget {
  const BookmarkFolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BookmarkFolderRepository repository = kMockMode
        ? BookmarkFolderMockRepositoryImpl()
        : BookmarkFolderRepositoryImpl(
            remote: BookmarkFolderRemoteDataSource(),
          );

    return ChangeNotifierProvider(
      create: (_) =>
          BookmarkFolderViewModel(repository: repository)..loadFolders(),
      child: const BookmarkFolderView(),
    );
  }
}
