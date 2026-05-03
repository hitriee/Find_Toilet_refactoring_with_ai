import 'package:find_toilet/core/domain/toilet_model.dart';
import 'package:find_toilet/core/domain/toilet_query_result.dart';
import 'package:find_toilet/core/utils/type_enum.dart';

abstract class ToiletDataSourceRepository {
  Future<ToiletQueryResult> getNearToilet(DynamicMap queryData);
  Future<ToiletQueryResult> searchToilet(DynamicMap queryData);
  Future<ToiletModel> getToilet(int toiletId);
}
