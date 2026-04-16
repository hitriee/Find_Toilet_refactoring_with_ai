import 'package:find_toilet/domain/repositories/bookmark_repository.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:flutter/material.dart';

class BookmarkViewModel with ChangeNotifier {
  final BookmarkRepository _bookmarkRepository;

  BookmarkViewModel({required BookmarkRepository bookmarkRepository})
      : _bookmarkRepository = bookmarkRepository;

  FutureToiletList getBookmarkList(int folderId, int page) async {
    final bookmarkList =
        await _bookmarkRepository.getToiletList(folderId, page);
    _addBookmarkList(bookmarkList);
    notifyListeners();
    return bookmarkList;
  }

  FutureVoid _addBookmarkList(ToiletList bookmarkList) {
    _bookmarkList.addAll(bookmarkList);
  }
}
