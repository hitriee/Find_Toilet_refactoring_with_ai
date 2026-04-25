import 'package:find_toilet/shared/utils/type_enum.dart';

abstract class BookmarkFolderRepository {
  Future<FolderList> getFolderList();
}
