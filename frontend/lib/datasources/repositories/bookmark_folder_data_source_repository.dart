import 'package:find_toilet/core/utils/type_enum.dart';

abstract class BookmarkFolderDataSourceRepository {
  Future<FolderList> getFolderList();
  Future<bool> createNewFolder(StringMap folderData);
  Future<void> updateFolderName(int folderId, {required StringMap folderData});
  Future<bool> deleteFolder(int folderId);
}
