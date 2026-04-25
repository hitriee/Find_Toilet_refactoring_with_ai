import 'package:find_toilet/data/datasources/mock/mock_toilet_db.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

/// 백엔드 없이 UI 확인용 더미 데이터 소스.
/// 화장실 데이터는 [MockToiletDb]에서 folderId로 필터링하여 가져옵니다.
class BookmarkMockDataSource {
  static const int _pageSize = 10;

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

  Future<void> addOrDeleteToilet({
    required List addFolderIdList,
    required List delFolderIdList,
    required int toiletId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
