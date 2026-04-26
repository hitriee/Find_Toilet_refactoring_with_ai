import 'package:find_toilet/core/config/app_config.dart';
import 'package:find_toilet/datasources/remote/bookmark_remote_data_source.dart';
import 'package:find_toilet/pages/bookmark/data/bookmark_mock_repository_impl.dart';
import 'package:find_toilet/pages/bookmark/data/bookmark_repository_impl.dart';
import 'package:find_toilet/pages/bookmark/domain/bookmark_repository.dart';
import 'package:find_toilet/pages/bookmark/presentation/bookmark_view.dart';
import 'package:find_toilet/pages/bookmark/presentation/bookmark_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatelessWidget {
  final int folderId;
  final String folderName;
  final int bookmarkCnt;

  const BookmarkPage({
    super.key,
    required this.folderId,
    required this.folderName,
    required this.bookmarkCnt,
  });

  @override
  Widget build(BuildContext context) {
    final BookmarkRepository bookmarkRepository = kMockMode
        ? BookmarkMockRepositoryImpl()
        : BookmarkRepositoryImpl(remote: BookmarkRemoteDataSource());

    return ChangeNotifierProvider(
      create: (_) => BookmarkViewModel(
        bookmarkRepository: bookmarkRepository,
        folderName: folderName,
        bookmarkCnt: bookmarkCnt,
        folderId: folderId,
      )..loadInitial(),
      child: const BookmarkView(),
    );
  }
}
