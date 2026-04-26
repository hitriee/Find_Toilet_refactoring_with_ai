import 'package:find_toilet/core/domain/toilet_model.dart';
import 'package:find_toilet/core/domain/toilet_repository.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:flutter/foundation.dart';

/// 검색 화면: Repository를 통해 키워드 검색·페이지 로드를 담당합니다.
class SearchViewModel extends ChangeNotifier {
  static const int _pageSize = 10;
  static const List<String> _orders = ['distance', 'score', 'comment'];

  final ToiletRepository _toiletRepository;
  final String keyword;
  final double latitude;
  final double longitude;
  final int sortIdx;
  final bool diaper;
  final bool kids;
  final bool disabled;
  final bool allDay;

  final List<ToiletModel> _items = [];
  int _nextPage = 0;
  bool _hasMore = true;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _errorMessage;

  SearchViewModel({
    required ToiletRepository toiletRepository,
    required this.keyword,
    required this.latitude,
    required this.longitude,
    required this.sortIdx,
    required this.diaper,
    required this.kids,
    required this.disabled,
    required this.allDay,
  }) : _toiletRepository = toiletRepository;

  ToiletList get toiletList => List.unmodifiable(_items);
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;
  String? get errorMessage => _errorMessage;

  DynamicMap _queryForPage(int page) {
    final orderIdx = sortIdx.clamp(0, _orders.length - 1);
    return {
      'lon': longitude,
      'lat': latitude,
      'keyword': keyword,
      'order': _orders[orderIdx],
      'allDay': allDay,
      'disabled': disabled,
      'kids': kids,
      'diaper': diaper,
      'page': page,
      'size': _pageSize,
    };
  }

  Future<void> loadInitial() async {
    _items.clear();
    _nextPage = 0;
    _hasMore = true;
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    await _fetchNextPage();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    await loadInitial();
  }

  Future<void> loadMore() async {
    if (_isLoading || _isLoadingMore || !_hasMore) {
      return;
    }
    _isLoadingMore = true;
    notifyListeners();
    await _fetchNextPage();
    _isLoadingMore = false;
    notifyListeners();
  }

  Future<void> _fetchNextPage() async {
    if (!_hasMore) {
      return;
    }
    try {
      final batch =
          await _toiletRepository.searchToilet(_queryForPage(_nextPage));
      _items.addAll(batch);
      _nextPage += 1;
      if (batch.length < _pageSize) {
        _hasMore = false;
      }
    } catch (_) {
      _errorMessage = '검색 결과를 불러오지 못했습니다.';
      _hasMore = false;
    }
  }
}
