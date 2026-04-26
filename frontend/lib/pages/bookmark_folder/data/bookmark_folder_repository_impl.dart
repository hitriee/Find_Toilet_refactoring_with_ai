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
}
