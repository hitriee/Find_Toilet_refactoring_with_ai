import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/repositories/bookmark_data_source_repository.dart';
import 'package:find_toilet/pages/bookmark/domain/bookmark_repository.dart';

class BookmarkRepositoryImpl extends BookmarkRepository {
  final BookmarkDataSourceRepository remote;

  BookmarkRepositoryImpl({required this.remote});

  @override
  FutureToiletList getToiletList({
    required int folderId,
    required int page,
  }) async {
    try {
      return await remote.getToiletList(folderId, page);
    } catch (error) {
      throw Exception('Failed to get toilet list');
    }
  }

  @override
  FutureVoid addOrDeleteToilet({
    required List addFolderIdList,
    required List delFolderIdList,
    required int toiletId,
  }) async {
    try {
      await remote.addOrDeleteToilet(
        addFolderIdList: addFolderIdList,
        delFolderIdList: delFolderIdList,
        toiletId: toiletId,
      );
    } catch (error) {
      final errorMode = addFolderIdList.isEmpty ? 'delete' : 'add';
      throw Exception("Failed to $errorMode near toilet");
    }
  }
}
