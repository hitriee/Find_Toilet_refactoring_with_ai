import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

/// 백엔드 없이 UI 확인용 더미 데이터 소스.
///
/// bookmark_folder_mock_data_source.dart의 폴더 ID(1~5)와 연동됩니다.
/// - folderId 1 (자주 가는 곳)  : 12개
/// - folderId 2 (회사 근처)      :  5개
/// - folderId 3 (집 근처)        :  8개
/// - folderId 4 (여행지)         :  0개
/// - folderId 5 (공원)           :  3개
class BookmarkMockDataSource {
  static const int _pageSize = 10;

  // ── 공통 헬퍼 ──────────────────────────────────────────────────────────────
  static DynamicMap _toilet({
    required int toiletId,
    required String name,
    required String address,
    required double lat,
    required double lon,
    required int folderId,
    double score = 4.0,
    int commentCnt = 0,
    String operationTime = '06:00 ~ 22:00',
    String phoneNumber = '-',
    bool diaper = false,
    bool allDay = false,
    bool disabled = false,
  }) =>
      {
        'toiletId': toiletId,
        'toiletName': name,
        'address': address,
        'operationTime': operationTime,
        'phoneNumber': phoneNumber,
        'comment': commentCnt,
        'score': score,
        'lat': lat,
        'lon': lon,
        'folderId': [folderId],
        'reviewId': 0,
        'dfemalePoo': disabled,
        'dmalePee': disabled,
        'dmalePoo': disabled,
        'cmalePee': false,
        'cmalePoo': false,
        'cfemalePoo': false,
        'diaper': diaper,
        'allDay': allDay,
      };

  // ── 폴더별 더미 데이터 ────────────────────────────────────────────────────
  static final Map<int, List<DynamicMap>> _db = {
    // folderId 1 — 자주 가는 곳 (12개, 페이지 0: 10개 / 페이지 1: 2개)
    1: [
      _toilet(toiletId: 101, folderId: 1, name: '강남역 공중화장실', address: '서울 강남구 강남대로 396', lat: 37.4979, lon: 127.0276, score: 4.5, commentCnt: 8, allDay: true, disabled: true),
      _toilet(toiletId: 102, folderId: 1, name: '코엑스몰 B1 화장실', address: '서울 강남구 봉은사로 524', lat: 37.5115, lon: 127.0595, score: 4.8, commentCnt: 15, operationTime: '10:00 ~ 22:00'),
      _toilet(toiletId: 103, folderId: 1, name: '선릉역 1번 출구 화장실', address: '서울 강남구 테헤란로 212', lat: 37.5047, lon: 127.0491, score: 4.2, commentCnt: 3, allDay: true),
      _toilet(toiletId: 104, folderId: 1, name: '역삼역 공중화장실', address: '서울 강남구 강남대로 286', lat: 37.5007, lon: 127.0364, score: 3.9, commentCnt: 5),
      _toilet(toiletId: 105, folderId: 1, name: '신논현역 공중화장실', address: '서울 강남구 강남대로 438', lat: 37.5044, lon: 127.0253, score: 4.1, commentCnt: 2, allDay: true),
      _toilet(toiletId: 106, folderId: 1, name: '삼성역 공중화장실', address: '서울 강남구 테헤란로 521', lat: 37.5088, lon: 127.0632, score: 4.3, commentCnt: 6, disabled: true),
      _toilet(toiletId: 107, folderId: 1, name: '양재역 1번 출구 화장실', address: '서울 서초구 강남대로 지하 1', lat: 37.4845, lon: 127.0343, score: 4.0, commentCnt: 1, allDay: true),
      _toilet(toiletId: 108, folderId: 1, name: '고속터미널역 공중화장실', address: '서울 서초구 신반포로 194', lat: 37.5046, lon: 127.0047, score: 4.4, commentCnt: 9, allDay: true, disabled: true, diaper: true),
      _toilet(toiletId: 109, folderId: 1, name: '서초역 공중화장실', address: '서울 서초구 서초대로 274', lat: 37.4915, lon: 127.0116, score: 3.8, commentCnt: 4),
      _toilet(toiletId: 110, folderId: 1, name: '교대역 공중화장실', address: '서울 서초구 서초대로 88', lat: 37.4933, lon: 126.9938, score: 4.1, commentCnt: 7, allDay: true),
      // 페이지 1
      _toilet(toiletId: 111, folderId: 1, name: '방배역 공중화장실', address: '서울 서초구 방배로 155', lat: 37.4815, lon: 126.9821, score: 3.7, commentCnt: 2),
      _toilet(toiletId: 112, folderId: 1, name: '사당역 공중화장실', address: '서울 동작구 사당로 지하 1', lat: 37.4765, lon: 126.9815, score: 4.0, commentCnt: 11, allDay: true, disabled: true),
    ],

    // folderId 2 — 회사 근처 (5개, 페이지 0에서 모두 반환)
    2: [
      _toilet(toiletId: 201, folderId: 2, name: '을지로입구역 공중화장실', address: '서울 중구 을지로 29', lat: 37.5662, lon: 126.9826, score: 4.2, commentCnt: 5, allDay: true, disabled: true),
      _toilet(toiletId: 202, folderId: 2, name: '시청역 공중화장실', address: '서울 중구 세종대로 지하 1', lat: 37.5658, lon: 126.9772, score: 4.0, commentCnt: 3, allDay: true),
      _toilet(toiletId: 203, folderId: 2, name: '종각역 공중화장실', address: '서울 종로구 종로 1가 지하 1', lat: 37.5700, lon: 126.9826, score: 3.9, commentCnt: 6, allDay: true, disabled: true),
      _toilet(toiletId: 204, folderId: 2, name: '광화문 공중화장실', address: '서울 종로구 세종대로 172', lat: 37.5759, lon: 126.9769, score: 4.5, commentCnt: 12, operationTime: '07:00 ~ 21:00', disabled: true),
      _toilet(toiletId: 205, folderId: 2, name: '청계광장 공중화장실', address: '서울 종로구 청계천로 1', lat: 37.5698, lon: 126.9784, score: 4.3, commentCnt: 8, operationTime: '06:00 ~ 23:00'),
    ],

    // folderId 3 — 집 근처 (8개, 페이지 0에서 모두 반환)
    3: [
      _toilet(toiletId: 301, folderId: 3, name: '마포구청 공중화장실', address: '서울 마포구 월드컵로 212', lat: 37.5662, lon: 126.9011, score: 4.1, commentCnt: 4, disabled: true),
      _toilet(toiletId: 302, folderId: 3, name: '홍대입구역 공중화장실', address: '서울 마포구 양화로 188', lat: 37.5572, lon: 126.9243, score: 4.6, commentCnt: 20, allDay: true, disabled: true, diaper: true),
      _toilet(toiletId: 303, folderId: 3, name: '합정역 공중화장실', address: '서울 마포구 양화로 지하 1', lat: 37.5499, lon: 126.9147, score: 4.0, commentCnt: 7, allDay: true),
      _toilet(toiletId: 304, folderId: 3, name: '망원한강공원 화장실', address: '서울 마포구 마포나루길 467', lat: 37.5544, lon: 126.8990, score: 4.2, commentCnt: 9, operationTime: '05:00 ~ 24:00'),
      _toilet(toiletId: 305, folderId: 3, name: '성산대교 남단 공중화장실', address: '서울 마포구 성산로 602', lat: 37.5527, lon: 126.8957, score: 3.8, commentCnt: 3),
      _toilet(toiletId: 306, folderId: 3, name: '이마트 마포점 화장실', address: '서울 마포구 마포대로 195', lat: 37.5490, lon: 126.9027, score: 4.4, commentCnt: 6, operationTime: '10:00 ~ 23:00', diaper: true),
      _toilet(toiletId: 307, folderId: 3, name: '공덕역 공중화장실', address: '서울 마포구 마포대로 지하 1', lat: 37.5447, lon: 126.9514, score: 4.1, commentCnt: 5, allDay: true, disabled: true),
      _toilet(toiletId: 308, folderId: 3, name: '상암월드컵경기장 공중화장실', address: '서울 마포구 월드컵로 240', lat: 37.5684, lon: 126.8976, score: 4.3, commentCnt: 2, operationTime: '09:00 ~ 18:00', disabled: true),
    ],

    // folderId 4 — 여행지 (0개)
    4: [],

    // folderId 5 — 공원 (3개, 페이지 0에서 모두 반환)
    5: [
      _toilet(toiletId: 501, folderId: 5, name: '올림픽공원 1화장실', address: '서울 송파구 올림픽로 424', lat: 37.5213, lon: 127.1219, score: 4.3, commentCnt: 11, operationTime: '06:00 ~ 22:00', disabled: true),
      _toilet(toiletId: 502, folderId: 5, name: '서울숲 공중화장실', address: '서울 성동구 뚝섬로 273', lat: 37.5446, lon: 127.0374, score: 4.7, commentCnt: 18, operationTime: '06:00 ~ 22:00', diaper: true, disabled: true),
      _toilet(toiletId: 503, folderId: 5, name: '한강시민공원 뚝섬지구 화장실', address: '서울 광진구 강변북로 139', lat: 37.5298, lon: 127.0652, score: 4.5, commentCnt: 14, operationTime: '05:00 ~ 24:00', allDay: true),
    ],
  };

  // ── public API ────────────────────────────────────────────────────────────
  Future<ToiletList> getToiletList(int folderId, int page) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final all = _db[folderId] ?? [];
    final start = page * _pageSize;
    if (start >= all.length) return [];
    final end = (start + _pageSize).clamp(0, all.length);
    return all
        .sublist(start, end)
        .map((json) => ToiletModel.fromJson(json))
        .toList();
  }

  Future<void> addOrDeleteToilet({
    required List addFolderIdList,
    required List delFolderIdList,
    required int toiletId,
  }) async {
    // Mock: 네트워크 지연만 흉내내고 실제 상태는 변경하지 않습니다.
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
