import 'package:find_toilet/core/utils/type_enum.dart';

class FolderModel {
  final int folderId, bookmarkCnt;
  final String folderName;

  FolderModel.fromJson(DynamicMap json)
      : folderId = json['folderId'],
        bookmarkCnt = json['folderLen'],
        folderName = json['folderName'];

  const FolderModel.create({
    required this.folderId,
    required this.bookmarkCnt,
    required this.folderName,
  });

  FolderModel copyWith({int? folderId, int? bookmarkCnt, String? folderName}) =>
      FolderModel.create(
        folderId: folderId ?? this.folderId,
        bookmarkCnt: bookmarkCnt ?? this.bookmarkCnt,
        folderName: folderName ?? this.folderName,
      );
}
