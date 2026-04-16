import 'package:flutter/foundation.dart';
import 'package:find_toilet/core/network/bookmark_provider.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

/// 즐겨찾기 폴더 목록 로딩을 ViewModel로 분리합니다.
class BookmarkFolderViewModel extends ChangeNotifier {
  final FolderProvider _folderProvider;

  BookmarkFolderViewModel({FolderProvider? folderProvider})
      : _folderProvider = folderProvider ?? FolderProvider();

  Future<FolderList> loadFolders() async {
    return _folderProvider.getFolderList();
  }
}

