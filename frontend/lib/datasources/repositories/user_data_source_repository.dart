import 'package:find_toilet/core/utils/type_enum.dart';

abstract class UserDataSourceRepository {
  FutureDynamicMap login();
  FutureDynamicMap changeName(String newName);
}
