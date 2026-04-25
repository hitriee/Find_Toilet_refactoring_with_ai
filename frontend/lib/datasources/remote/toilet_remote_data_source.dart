import 'package:dio/dio.dart';
import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

class ToiletQueryResult {
  ToiletQueryResult({required this.toilets, this.totalPages});
  final ToiletList toilets;
  final int? totalPages;
}

class ToiletRemoteDataSource extends ApiProvider {
  Future<ToiletQueryResult> searchToilet(DynamicMap queryData) async {
    final response = await _getWithAuth(searchToiletUrl, queryData);
    final data = response.data['content'] as List<dynamic>? ?? [];
    final totalPages = response.data['totalPages'] as int?;
    final toilets = data.map((json) => ToiletModel.fromJson(json)).toList();
    return ToiletQueryResult(toilets: toilets, totalPages: totalPages);
  }

  Future<ToiletQueryResult> getNearToilet(DynamicMap queryData) async {
    final response = await _getWithAuth(nearToiletUrl, queryData);
    final data = response.data['content'] as List<dynamic>? ?? [];
    final totalPages = response.data['totalPages'] as int?;
    final toilets = data.map((json) => ToiletModel.fromJson(json)).toList();
    return ToiletQueryResult(toilets: toilets, totalPages: totalPages);
  }

  Future<ToiletModel> getToilet(int toiletId) async {
    final response = await _getWithAuth(eachToiletUrl(toiletId), null);
    final data = response.data['content'];
    if (data == null) {
      throw Exception('Toilet content is null');
    }
    return ToiletModel.fromJson(data);
  }

  Future<Response<dynamic>> _getWithAuth(
    String url,
    DynamicMap? queryParameters,
  ) {
    if (token == null) {
      return dio.get(url, queryParameters: queryParameters);
    }
    return dioWithToken(url: url, method: 'GET')
        .get(url, queryParameters: queryParameters);
  }
}
