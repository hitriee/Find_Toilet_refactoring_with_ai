//* bookmark list
import 'package:find_toilet/core/config/app_config.dart';
import 'package:find_toilet/core/config/state_provider.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/mock/bookmark_mock_data_source.dart';
import 'package:find_toilet/datasources/remote/bookmark_remote_data_source.dart';
import 'package:find_toilet/datasources/repositories/bookmark_data_source_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

ToiletList bookmarkList(BuildContext context) =>
    context.read<ReviewBookmarkStateProvider>().bookmarkList;

FutureToiletList getBookmarkList(
  BuildContext context, {
  required int folderId,
}) async {
  final BookmarkDataSourceRepository dataSource =
      kMockMode ? BookmarkMockDataSource() : BookmarkRemoteDataSource();
  final list = await dataSource.getToiletList(folderId, ScrollProvider().page);
  context.read<ReviewBookmarkStateProvider>().addBookmarkList(list);
  return list;
}

void initBookmarkList(BuildContext context) =>
    context.read<ReviewBookmarkStateProvider>().initBookmarkList();
