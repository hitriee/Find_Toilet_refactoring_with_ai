import 'package:find_toilet/data/datasources/remote/bookmark_remote_data_source.dart';
import 'package:find_toilet/domain/repositories/bookmark_repository.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

class BookmarkRepositoryImpl extends BookmarkRepository {
  final BookmarkRemoteDataSource remote;

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
