abstract class BookmarkRepository {
  FutureToiletList getToiletList();
  FutureVoid addOrDeleteToilet(
      List addFolderIdList, List delFolderIdList, int toiletId);
}
