import 'package:find_toilet/core/domain/toilet_model.dart';
import 'package:find_toilet/core/utils/type_enum.dart';

abstract class ToiletRepository {
  FutureToiletList searchToilet(DynamicMap queryData);
  FutureToiletList getNearToilet(DynamicMap queryData);
  Future<ToiletModel> getToilet(int toiletId);
}
