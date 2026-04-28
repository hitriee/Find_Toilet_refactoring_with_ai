import 'package:find_toilet/core/network/api_provider.dart';
import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/pages/bookmark/domain/bookmark_model.dart';

class BookmarkFolderRemoteDataSource extends ApiProvider {
  Future<FolderList> getFolderList() async {
    final response = await dioWithToken(url: folderListUrl, method: 'GET')
        .get(folderListUrl);
    final data = response.data['data'];
    return data.map<FolderModel>((json) => FolderModel.fromJson(json)).toList();
  }

  FutureBool createNewFolder(StringMap folderData) =>
      createApi(createFolderUrl, data: folderData);

  FutureVoid updateFolderName(int folderId,
          {required StringMap folderData}) =>
      updateApi(updateFolderUrl(folderId), data: folderData);

  FutureBool deleteFolder(int folderId) => deleteApi(deleteFolderUrl(folderId));
}
