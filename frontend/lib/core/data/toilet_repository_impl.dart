import 'package:find_toilet/core/config/state_provider.dart';
import 'package:find_toilet/core/domain/toilet_model.dart';
import 'package:find_toilet/core/domain/toilet_repository.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/remote/toilet_remote_data_source.dart';

class ToiletRepositoryImpl extends ToiletRepository {
  final ToiletRemoteDataSource remote;
  ToiletRepositoryImpl({required this.remote});

  @override
  FutureToiletList getNearToilet(DynamicMap queryData) async {
    try {
      final result = await remote.getNearToilet(queryData);
      ScrollProvider().setTotal(result.totalPages);
      return result.toilets;
    } catch (error) {
      throw Exception('Failed to get near toilet');
    }
  }

  @override
  Future<ToiletModel> getToilet(int toiletId) async {
    try {
      return remote.getToilet(toiletId);
    } catch (error) {
      throw Exception('Failed to get toilet: $error');
    }
  }

  @override
  FutureToiletList searchToilet(DynamicMap queryData) async {
    try {
      final result = await remote.searchToilet(queryData);
      return result.toilets;
    } catch (error) {
      throw Exception('Failed to search toilet: $error');
    }
  }
}
