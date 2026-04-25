import 'package:find_toilet/data/datasources/mock/bookmark_mock_data_source.dart';
import 'package:find_toilet/domain/repositories/bookmark_repository.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

class BookmarkMockRepositoryImpl extends BookmarkRepository {
  final _dataSource = BookmarkMockDataSource();

  @override
  FutureToiletList getToiletList({
    required int folderId,
    required int page,
  }) =>
      _dataSource.getToiletList(folderId, page);

  @override
  FutureVoid addOrDeleteToilet({
    required List addFolderIdList,
    required List delFolderIdList,
    required int toiletId,
  }) =>
      _dataSource.addOrDeleteToilet(
        addFolderIdList: addFolderIdList,
        delFolderIdList: delFolderIdList,
        toiletId: toiletId,
      );
}
