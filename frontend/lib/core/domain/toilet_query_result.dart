import 'package:find_toilet/core/utils/type_enum.dart';

class ToiletQueryResult {
  ToiletQueryResult({required this.toilets, this.totalPages});
  final ToiletList toilets;
  final int? totalPages;
}
