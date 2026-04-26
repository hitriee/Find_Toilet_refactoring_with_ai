import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/pages/bookmark_folder/domain/bookmark_folder_repository.dart';
import 'package:flutter/foundation.dart';

class BookmarkFolderViewModel extends ChangeNotifier {
  final BookmarkFolderRepository _repository;
  late final Future<FolderList> _foldersFuture;

  Future<FolderList> get foldersFuture => _foldersFuture;

  BookmarkFolderViewModel({required BookmarkFolderRepository repository})
      : _repository = repository;

  void loadFolders() {
    _foldersFuture = _repository.getFolderList();
  }
}
