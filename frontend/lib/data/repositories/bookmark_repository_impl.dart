class BookmarkRepositoryImpl extends BookmarkRepository {
  final BookmarkRemoteDatasource remote;
  BookmarkRepositoryImpl({required this.remote});
  //* 즐겨찾기 목록 조회
  FutureToiletList getToiletList(int folderId, int page) async {
    try {
      final toiletList = await remote.getToiletList(folderId, page);
      ScrollProvider().setTotal(response.data['size']);
      return toiletList;
    } catch (error) {
      throw Exception('Failed to get toilet list');
    }
  }

  //* 즐겨찾기에 추가/삭제
  FutureVoid addOrDeleteToilet({
    required List addFolderIdList,
    required List delFolderIdList,
    required int toiletId,
  }) async {
    try {
      await remote.addOrDeleteToilet(
          addFolderIdList, delFolderIdList, toiletId);
      return null;
    } catch (error) {
      final errorMode = addFolderIdList.isEmpty ? 'delete' : 'add';
      throw Exception("Failed to $errorMode near toilet");
    }
  }
}
