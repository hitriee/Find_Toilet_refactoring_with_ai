import 'package:find_toilet/models/bookmark_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

/// 백엔드 없이 UI 확인용 더미 데이터 소스.
/// [BookmarkFolderRemoteDataSource]와 동일한 인터페이스를 제공합니다.
class BookmarkFolderMockDataSource {
  static const _rawData = [
    {'folderId': 1, 'folderLen': 12, 'folderName': '자주 가는 곳'},
    {'folderId': 2, 'folderLen': 5, 'folderName': '회사 근처'},
    {'folderId': 3, 'folderLen': 8, 'folderName': '집 근처'},
    {'folderId': 4, 'folderLen': 0, 'folderName': '여행지'},
    {'folderId': 5, 'folderLen': 3, 'folderName': '공원'},
  ];

  Future<FolderList> getFolderList() async {
    // 실제 네트워크 지연을 흉내냅니다.
    await Future.delayed(const Duration(milliseconds: 500));
    return _rawData
        .map((json) => FolderModel.fromJson(json as DynamicMap))
        .toList();
  }
}
