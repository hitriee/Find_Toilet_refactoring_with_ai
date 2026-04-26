import 'package:find_toilet/core/utils/type_enum.dart';

abstract class BookmarkFolderRepository {
  Future<FolderList> getFolderList();
}
