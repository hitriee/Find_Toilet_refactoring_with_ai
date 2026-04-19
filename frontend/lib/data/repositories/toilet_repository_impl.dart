import 'package:find_toilet/data/datasources/remote/toilet_remote_datasource.dart';
import 'package:find_toilet/domain/repositories/toilet_repository.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/presentation/view_models/scroll_provider.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

class ToiletRepositoryImpl extends ToiletRepository {
  final ToiletRemoteDatasource remote;
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
