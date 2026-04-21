import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/presentation/view_models/scroll_provider.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

// 홈 화면 화장실
class ToiletProvider extends ApiProvider {
  //* public
  FutureToiletList searchToilet(DynamicMap queryData) =>
      _searchToilet(queryData);

  FutureToiletList getNearToilet(DynamicMap queryData) =>
      _getNearToilet(queryData);

  Future<ToiletModel> getToilet(int toiletId) => _getToilet(toiletId);

  //* private
  FutureToiletList _getNearToilet(DynamicMap queryData) async {
    try {
      final response = token == null
          ? await dio.get(
              nearToiletUrl,
              queryParameters: queryData,
            )
          : await dioWithToken(url: nearToiletUrl, method: 'GET').get(
              nearToiletUrl,
              queryParameters: queryData,
            );
      final data = response.data['content'];
      if (data.isNotEmpty) {
        ToiletList toiletList = data.map<ToiletModel>((json) {
          return ToiletModel.fromJson(json);
        }).toList();
        ScrollProvider().setTotal(response.data['totalPages']);
        return toiletList;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception('주변 화장실 조회 실패: $error');
    }
  }

  Future<ToiletModel> _getToilet(int toiletId) async {
    try {
      final response = token == null
          ? await dio.get(eachToiletUrl(toiletId))
          : await dioWithToken(url: eachToiletUrl(toiletId), method: 'GET').get(
              eachToiletUrl(toiletId),
            );
      final data = response.data['content'];
      if (data.isNotEmpty) {
        ToiletModel toiletModel = ToiletModel.fromJson(data);
        return toiletModel;
      } else {
        throw Exception('화장실 정보가 없습니다 (toiletId: $toiletId)');
      }
    } catch (error) {
      throw Exception('화장실 상세 조회 실패 (toiletId: $toiletId): $error');
    }
  }

  FutureToiletList _searchToilet(DynamicMap queryData) async {
    try {
      final response = token == null
          ? await dio.get(
              searchToiletUrl,
              queryParameters: queryData,
            )
          : await dioWithToken(url: searchToiletUrl, method: 'GET').get(
              searchToiletUrl,
              queryParameters: queryData,
            );
      final data = response.data['content'];
      ToiletList toiletList = data.map<ToiletModel>((json) {
        return ToiletModel.fromJson(json);
      }).toList();
      ScrollProvider().setTotal(response.data['totalPages']);
      return toiletList;
    } catch (error) {
      throw Exception('화장실 검색 실패: $error');
    }
  }
}
