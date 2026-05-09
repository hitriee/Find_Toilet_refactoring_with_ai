import 'package:find_toilet/pages/bookmark/domain/bookmark_model.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/pages/bookmark_folder/domain/bookmark_folder_repository.dart';
import 'package:flutter/foundation.dart';

class BookmarkFolderViewModel extends ChangeNotifier {
  final BookmarkFolderRepository _repository;

  List<FolderModel> _folders = [];
  bool _isLoading = false;
  String? _error;

  List<FolderModel> get folders => List.unmodifiable(_folders);
  bool get isLoading => _isLoading;
  String? get error => _error;

  BookmarkFolderViewModel({required BookmarkFolderRepository repository})
      : _repository = repository;

  void loadFolders() {
    _isLoading = true;
    _error = null;
    notifyListeners();
    _repository.getFolderList().then((list) {
      _folders = list;
      _isLoading = false;
      notifyListeners();
    }).catchError((_) {
      _error = '폴더 목록을 불러오는 데 실패했습니다.';
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> createFolder(String name) async {
    await _repository.createNewFolder({'folderName': name});
    final tempId = -DateTime.now().millisecondsSinceEpoch;
    _folders.add(FolderModel.create(
      folderId: tempId,
      folderName: name,
      bookmarkCnt: 0,
    ));
    notifyListeners();
  }

  Future<void> renameFolder(int folderId, String newName) async {
    await _repository.updateFolderName(folderId,
        folderData: {'folderName': newName});
    final index = _folders.indexWhere((f) => f.folderId == folderId);
    if (index != -1) {
      _folders[index] = _folders[index].copyWith(folderName: newName);
      notifyListeners();
    }
  }

  FutureVoid deleteFolder(int folderId) async {
    await _repository.deleteFolder(folderId);
    _folders.removeWhere((f) => f.folderId == folderId);
    notifyListeners();
  }
}
