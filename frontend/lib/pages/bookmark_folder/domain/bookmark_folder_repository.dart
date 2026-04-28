import 'package:find_toilet/core/utils/type_enum.dart';

abstract class BookmarkFolderRepository {
  Future<FolderList> getFolderList();
  FutureBool createNewFolder(StringMap folderData);
  FutureVoid updateFolderName(int folderId, {required StringMap folderData});
  FutureBool deleteFolder(int folderId);
}
