import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

abstract class ToiletRepository {
  FutureToiletList searchToilet(DynamicMap queryData);
  FutureToiletList getNearToilet(DynamicMap queryData);
  Future<ToiletModel> getToilet(int toiletId);
}
