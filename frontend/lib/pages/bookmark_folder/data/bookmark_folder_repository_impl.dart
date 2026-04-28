import 'package:find_toilet/core/utils/type_enum.dart';
import 'package:find_toilet/datasources/remote/bookmark_folder_remote_data_source.dart';
import 'package:find_toilet/pages/bookmark_folder/domain/bookmark_folder_repository.dart';

class BookmarkFolderRepositoryImpl implements BookmarkFolderRepository {
  final BookmarkFolderRemoteDataSource remote;

  BookmarkFolderRepositoryImpl({required this.remote});

  @override
  Future<FolderList> getFolderList() async {
    try {
      return await remote.getFolderList();
    } catch (e) {
      throw Exception('폴더 목록을 불러오는 데 실패했습니다.');
    }
  }

  @override
  FutureBool createNewFolder(StringMap folderData) async {
    try {
      return await remote.createNewFolder(folderData);
    } catch (e) {
      throw Exception('폴더 생성에 실패했습니다.');
    }
  }

  @override
  FutureVoid updateFolderName(int folderId,
      {required StringMap folderData}) async {
    try {
      await remote.updateFolderName(folderId, folderData: folderData);
    } catch (e) {
      throw Exception('폴더 이름 수정에 실패했습니다.');
    }
  }

  @override
  FutureBool deleteFolder(int folderId) async {
    try {
      return await remote.deleteFolder(folderId);
    } catch (e) {
      throw Exception('폴더 삭제에 실패했습니다.');
    }
  }
}
