import 'package:find_toilet/core/domain/toilet_model.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/mock/mock_toilet_db.dart';
import 'package:find_toilet/datasources/repositories/bookmark_data_source_repository.dart';

/// 백엔드 없이 UI 확인용 더미 ��이터 소스.
/// 화장실 데이터는 [MockToiletDb]에서 folderId로 필터링하여 가져옵니다.
class BookmarkMockDataSource implements BookmarkDataSourceRepository {
  static const int _pageSize = 10;

  @override
  Future<ToiletList> getToiletList(int folderId, int page) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final all = MockToiletDb.getByFolderId(folderId);
    final start = page * _pageSize;
    if (start >= all.length) return [];
    return all
        .sublist(start, (start + _pageSize).clamp(0, all.length))
        .map((json) => ToiletModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> addOrDeleteToilet({
    required List addFolderIdList,
    required List delFolderIdList,
    required int toiletId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final toilet = MockToiletDb.all.firstWhere(
      (t) => t['toiletId'] == toiletId,
      orElse: () => {},
    );
    if (toilet.isEmpty) return;

    final currentIds = List<int>.from(toilet['folderId'] as List);
    for (final id in addFolderIdList) {
      if (!currentIds.contains(id)) currentIds.add(id as int);
    }
    currentIds.removeWhere((id) => delFolderIdList.contains(id));
    toilet['folderId'] = currentIds;
  }
}
