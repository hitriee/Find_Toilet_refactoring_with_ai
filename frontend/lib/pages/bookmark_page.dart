import 'package:find_toilet/data/datasources/remote/bookmark_remote_datasource.dart';
import 'package:find_toilet/data/repositories/bookmark_repository_impl.dart';
import 'package:find_toilet/domain/repositories/bookmark_repository.dart';
import 'package:find_toilet/presentation/view_models/bookmark_view_model.dart';
import 'package:find_toilet/presentation/views/bookmark_view.dart';
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
    final BookmarkRepository bookmarkRepository = BookmarkRepositoryImpl(
      remote: BookmarkRemoteDatasource(),
    );

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
