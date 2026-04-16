import 'package:find_toilet/core/network/api_provider.dart';

class BookmarkRemoteDatasource extends ApiProvider {
  FutureToiletList getToiletList(int folderId, int page) async {
    final response =
        await _getWithAuth(bookmarkListUrl(folderId), {'page': page});
    final data = response.data['data'];
    if (data.isEmpty) {
      return [];
    }
    ToiletList toiletList =
        data.map((element) => {ToiletModel.fromJson(element)});

    return toiletList;
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
