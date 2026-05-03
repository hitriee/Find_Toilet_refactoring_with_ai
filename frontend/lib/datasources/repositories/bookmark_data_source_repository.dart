import 'package:find_toilet/core/utils/type_enum.dart';

abstract class BookmarkDataSourceRepository {
  Future<ToiletList> getToiletList(int folderId, int page);
  Future<void> addOrDeleteToilet({
    required List addFolderIdList,
    required List delFolderIdList,
    required int toiletId,
  });
}
