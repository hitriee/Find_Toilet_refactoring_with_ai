import 'package:find_toilet/data/datasources/remote/bookmark_folder_remote_data_source.dart';
import 'package:find_toilet/data/repositories/bookmark_folder_repository_impl.dart';
import 'package:find_toilet/domain/repositories/bookmark_folder_repository.dart';
import 'package:find_toilet/presentation/view_models/bookmark_folder_view_model.dart';
import 'package:find_toilet/presentation/views/bookmark_folder_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkFolderPage extends StatelessWidget {
  const BookmarkFolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BookmarkFolderRepository repository = BookmarkFolderRepositoryImpl(
      remote: BookmarkFolderRemoteDataSource(),
    );

    return ChangeNotifierProvider(
      create: (_) => BookmarkFolderViewModel(repository: repository)
        ..loadFolders(),
      child: const BookmarkFolderView(),
    );
  }
}
