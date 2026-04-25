import 'package:find_toilet/data/datasources/mock/toilet_mock_data_source.dart';
import 'package:find_toilet/domain/repositories/toilet_repository.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

class ToiletMockRepositoryImpl extends ToiletRepository {
  final _dataSource = ToiletMockDataSource();

  @override
  FutureToiletList getNearToilet(DynamicMap queryData) async {
    final result = await _dataSource.getNearToilet(queryData);
    return result.toilets;
  }

  @override
  FutureToiletList searchToilet(DynamicMap queryData) async {
    final result = await _dataSource.searchToilet(queryData);
    return result.toilets;
  }

  @override
  Future<ToiletModel> getToilet(int toiletId) =>
      _dataSource.getToilet(toiletId);
}
