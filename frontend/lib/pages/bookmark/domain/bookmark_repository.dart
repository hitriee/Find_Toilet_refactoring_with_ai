import 'package:find_toilet/shared/utils/type_enum.dart';

abstract class BookmarkRepository {
  FutureToiletList getToiletList({
    required int folderId,
    required int page,
  });

  FutureVoid addOrDeleteToilet({
    required List addFolderIdList,
    required List delFolderIdList,
    required int toiletId,
  });
}
