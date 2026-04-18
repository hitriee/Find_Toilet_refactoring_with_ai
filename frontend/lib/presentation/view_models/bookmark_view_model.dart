import 'package:find_toilet/domain/repositories/bookmark_repository.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';
import 'package:flutter/material.dart';

class BookmarkViewModel extends ChangeNotifier {
  static const int _pageSize = 10;
  final BookmarkRepository _bookmarkRepository;
  final String _folderName;
  final int _folderId;
  int _bookmarkCnt;
  final ToiletList _bookmarkList = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _page = 0;
  String? _errorMessage;

  BookmarkViewModel(
      {required BookmarkRepository bookmarkRepository,
      required String folderName,
      required int bookmarkCnt,
      required int folderId})
      : _bookmarkRepository = bookmarkRepository,
        _folderName = folderName,
        _bookmarkCnt = bookmarkCnt,
        _folderId = folderId;

  String get folderName => _folderName;
  int get bookmarkCnt => _bookmarkCnt;
  int get folderId => _folderId;
  ToiletList get bookmarkList => List.unmodifiable(_bookmarkList);
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;
  String? get errorMessage => _errorMessage;

  FutureVoid loadInitial() async {
    _isLoading = true;
    _errorMessage = null;
    _bookmarkList.clear();
    _page = 0;
    _hasMore = true;
    notifyListeners();
    await _fetchPage();
    _isLoading = false;
    notifyListeners();
  }

  FutureVoid refresh() async {
    await loadInitial();
  }

  FutureVoid loadMore() async {
    if (_isLoading || _isLoadingMore || !_hasMore) {
      return;
    }

    _isLoadingMore = true;
    notifyListeners();
    await _fetchPage();
    _isLoadingMore = false;
    notifyListeners();
  }

  FutureVoid _fetchPage() async {
    try {
      final newBookmarks = await _bookmarkRepository.getToiletList(
        folderId: _folderId,
        page: _page,
      );
      _bookmarkList.addAll(newBookmarks);
      _bookmarkCnt = _bookmarkList.length;
      _page += 1;
      if (newBookmarks.length < _pageSize) {
        _hasMore = false;
      }
    } catch (error) {
      _errorMessage = '즐겨찾기 목록을 불러오지 못했습니다.';
      _hasMore = false;
    }
  }
}
