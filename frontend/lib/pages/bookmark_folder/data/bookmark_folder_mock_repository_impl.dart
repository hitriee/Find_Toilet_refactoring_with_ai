import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/mock/bookmark_folder_mock_data_source.dart';
import 'package:find_toilet/pages/bookmark_folder/domain/bookmark_folder_repository.dart';

class BookmarkFolderMockRepositoryImpl implements BookmarkFolderRepository {
  final _dataSource = BookmarkFolderMockDataSource();

  @override
  Future<FolderList> getFolderList() => _dataSource.getFolderList();
}
