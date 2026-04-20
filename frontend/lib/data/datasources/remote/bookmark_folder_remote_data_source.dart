import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/models/bookmark_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

class BookmarkFolderRemoteDataSource extends ApiProvider {
  Future<FolderList> getFolderList() async {
    final response =
        await dioWithToken(url: folderListUrl, method: 'GET').get(folderListUrl);
    final data = response.data['data'];
    return data
        .map<FolderModel>((json) => FolderModel.fromJson(json))
        .toList();
  }
}
