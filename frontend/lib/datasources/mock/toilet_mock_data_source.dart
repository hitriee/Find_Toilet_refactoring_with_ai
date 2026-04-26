import 'package:find_toilet/core/domain/toilet_model.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/mock/mock_toilet_db.dart';
import 'package:find_toilet/datasources/remote/toilet_remote_data_source.dart';

/// 백엔드 없이 UI 확인용 더미 데이터 소스.
/// 화장실 데이터는 [MockToiletDb]에서 가져옵니다.
class ToiletMockDataSource {
  Future<ToiletQueryResult> getNearToilet(DynamicMap queryData) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final page = MockToiletDb.getNearPage(queryData);
    final toilets = page.map((json) => ToiletModel.fromJson(json)).toList();
    final totalItems = MockToiletDb.all.length;
    final size = (queryData['size'] as num?)?.toInt() ?? 20;
    final totalPages = (totalItems / size).ceil();
    return ToiletQueryResult(toilets: toilets, totalPages: totalPages);
  }

  Future<ToiletQueryResult> searchToilet(DynamicMap queryData) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final page = MockToiletDb.searchPage(queryData);
    final toilets = page.map((json) => ToiletModel.fromJson(json)).toList();
    // 검색 총 페이지는 실제 매칭 수 기준으로 계산
    final keyword = ((queryData['keyword'] as String?) ?? '').toLowerCase();
    final matchCount = MockToiletDb.all.where((t) {
      final name = (t['toiletName'] as String).toLowerCase();
      final addr = (t['address'] as String).toLowerCase();
      return name.contains(keyword) || addr.contains(keyword);
    }).length;
    final size = (queryData['size'] as num?)?.toInt() ?? 10;
    final totalPages = matchCount == 0 ? 0 : (matchCount / size).ceil();
    return ToiletQueryResult(toilets: toilets, totalPages: totalPages);
  }

  Future<ToiletModel> getToilet(int toiletId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final json = MockToiletDb.findById(toiletId);
    if (json == null) {
      throw Exception('Mock: 화장실을 찾을 수 없습니다 (id: $toiletId)');
    }
    return ToiletModel.fromJson(json);
  }
}
