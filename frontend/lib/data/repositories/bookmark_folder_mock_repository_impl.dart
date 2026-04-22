import 'package:find_toilet/data/datasources/mock/bookmark_folder_mock_data_source.dart';
import 'package:find_toilet/domain/repositories/bookmark_folder_repository.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

class BookmarkFolderMockRepositoryImpl implements BookmarkFolderRepository {
  final _dataSource = BookmarkFolderMockDataSource();

  @override
  Future<FolderList> getFolderList() => _dataSource.getFolderList();
}
