import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

class BookmarkRemoteDataSource extends ApiProvider {
  FutureToiletList getToiletList(int folderId, int page) async {
    final response = await dioWithToken(
      url: bookmarkListUrl(folderId),
      method: 'GET',
    ).get(
      bookmarkListUrl(folderId),
      queryParameters: {'page': page},
    );
    final data = response.data['data'];
    if (data.isEmpty) {
      return [];
    }
    return data
        .map<ToiletModel>((element) => ToiletModel.fromJson(element))
        .toList();
  }

  FutureVoid addOrDeleteToilet({
    required List addFolderIdList,
    required List delFolderIdList,
    required int toiletId,
  }) async =>
      createApi(
        addToiletUrl,
        data: {
          'addFolderIdList': addFolderIdList,
          'delFolderIdList': delFolderIdList,
          'toiletId': toiletId,
        },
      );
}
