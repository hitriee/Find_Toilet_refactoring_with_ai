import 'package:find_toilet/shared/utils/type_enum.dart';

/// 모든 Mock 더미 화장실 데이터의 단일 진실 공급원(Single Source of Truth).
///
/// [bookmark_mock_data_source.dart]와 [toilet_mock_data_source.dart]가
/// 이 DB를 공유하므로 양쪽의 화장실 ID·정보가 항상 일치합니다.
///
/// folderId 연동:
///   [] = 즐겨찾기 안 됨
///   [1] = '자주 가는 곳' (12개)
///   [2] = '회사 근처'   ( 5개)
///   [3] = '집 근처'     ( 8개)
///   [5] = '공원'        ( 3개)
class MockToiletDb {
  MockToiletDb._();

  // ── 헬퍼 ─────────────────────────────────────────────────────────────────
  static DynamicMap _t({
    required int id,
    required String name,
    required String address,
    required double lat,
    required double lon,
    List<int> folderIds = const [],
    double score = 4.0,
    int comment = 0,
    String operationTime = '06:00 ~ 22:00',
    String phoneNumber = '-',
    bool allDay = false,
    bool disabled = false,
    bool kids = false,
    bool diaper = false,
  }) =>
      {
        'toiletId': id,
        'toiletName': name,
        'address': address,
        'operationTime': allDay ? '00:00 ~ 24:00' : operationTime,
        'phoneNumber': phoneNumber,
        'comment': comment,
        'score': score,
        'lat': lat,
        'lon': lon,
        'folderId': folderIds,
        'reviewId': 0,
        // 장애인
        'dmalePee': disabled,
        'dmalePoo': disabled,
        'dfemalePoo': disabled,
        // 어린이
        'cmalePee': kids,
        'cmalePoo': kids,
        'cfemalePoo': kids,
        // 기저귀·24시
        'diaper': diaper,
        'allDay': allDay,
      };

  // ── 전체 화장실 목록 ──────────────────────────────────────────────────────
  static final List<DynamicMap> all = [
    // ── 즐겨찾기 미등록 (ID 1~12) ──────────────────────────────────────────
    _t(id: 1,  name: '서울역 공중화장실',       address: '서울 중구 통일로 1',           lat: 37.5547, lon: 126.9707, score: 4.3, comment: 22, allDay: true,  disabled: true),
    _t(id: 2,  name: '명동 공중화장실',         address: '서울 중구 명동길 14',          lat: 37.5636, lon: 126.9849, score: 4.1, comment: 18, allDay: true),
    _t(id: 3,  name: '동대문역 공중화장실',     address: '서울 중구 을지로 281',         lat: 37.5667, lon: 127.0076, score: 3.9, comment: 11, allDay: true,  disabled: true),
    _t(id: 4,  name: '이태원 공중화장실',       address: '서울 용산구 이태원로 177',     lat: 37.5347, lon: 126.9941, score: 4.0, comment:  7, allDay: true),
    _t(id: 5,  name: '건대입구역 공중화장실',   address: '서울 광진구 능동로 217',       lat: 37.5404, lon: 127.0703, score: 4.2, comment: 15, allDay: true,  disabled: true),
    _t(id: 6,  name: '잠실역 공중화장실',       address: '서울 송파구 올림픽로 289',     lat: 37.5132, lon: 127.1001, score: 4.5, comment: 30, allDay: true,  disabled: true,  diaper: true),
    _t(id: 7,  name: '신촌역 공중화장실',       address: '서울 서대문구 신촌로 83',      lat: 37.5556, lon: 126.9371, score: 4.1, comment: 12, allDay: true,  disabled: true),
    _t(id: 8,  name: '연남동 공중화장실',       address: '서울 마포구 연남로 51',        lat: 37.5617, lon: 126.9253, score: 3.8, comment:  5),
    _t(id: 9,  name: '왕십리역 공중화장실',     address: '서울 성동구 왕십리광장로 1',   lat: 37.5613, lon: 127.0375, score: 4.0, comment:  9, allDay: true,  disabled: true),
    _t(id: 10, name: '대학로 공중화장실',       address: '서울 종로구 대학로 116',       lat: 37.5826, lon: 127.0019, score: 3.9, comment:  4, disabled: true),
    _t(id: 11, name: '인사동 공중화장실',       address: '서울 종로구 인사동길 45',      lat: 37.5742, lon: 126.9849, score: 4.2, comment: 13),
    _t(id: 12, name: '수유역 공중화장실',       address: '서울 강북구 도봉로 329',       lat: 37.6386, lon: 127.0261, score: 4.0, comment:  6, allDay: true,  disabled: true),

    // ── folderId 1 — 자주 가는 곳 (ID 101~112) ────────────────────────────
    _t(id: 101, folderIds: [1], name: '강남역 공중화장실',         address: '서울 강남구 강남대로 396',    lat: 37.4979, lon: 127.0276, score: 4.5, comment:  8, allDay: true,  disabled: true),
    _t(id: 102, folderIds: [1], name: '코엑스몰 B1 화장실',        address: '서울 강남구 봉은사로 524',    lat: 37.5115, lon: 127.0595, score: 4.8, comment: 15, operationTime: '10:00 ~ 22:00'),
    _t(id: 103, folderIds: [1], name: '선릉역 1번 출구 화장실',    address: '서울 강남구 테헤란로 212',    lat: 37.5047, lon: 127.0491, score: 4.2, comment:  3, allDay: true),
    _t(id: 104, folderIds: [1], name: '역삼역 공중화장실',         address: '서울 강남구 강남대로 286',    lat: 37.5007, lon: 127.0364, score: 3.9, comment:  5),
    _t(id: 105, folderIds: [1], name: '신논현역 공중화장실',       address: '서울 강남구 강남대로 438',    lat: 37.5044, lon: 127.0253, score: 4.1, comment:  2, allDay: true),
    _t(id: 106, folderIds: [1], name: '삼성역 공중화장실',         address: '서울 강남구 테헤란로 521',    lat: 37.5088, lon: 127.0632, score: 4.3, comment:  6, disabled: true),
    _t(id: 107, folderIds: [1], name: '양재역 1번 출구 화장실',    address: '서울 서초구 강남대로 지하 1', lat: 37.4845, lon: 127.0343, score: 4.0, comment:  1, allDay: true),
    _t(id: 108, folderIds: [1], name: '고속터미널역 공중화장실',   address: '서울 서초구 신반포로 194',    lat: 37.5046, lon: 127.0047, score: 4.4, comment:  9, allDay: true,  disabled: true, diaper: true),
    _t(id: 109, folderIds: [1], name: '서초역 공중화장실',         address: '서울 서초구 서초대로 274',    lat: 37.4915, lon: 127.0116, score: 3.8, comment:  4),
    _t(id: 110, folderIds: [1], name: '교대역 공중화장실',         address: '서울 서초구 서초대로 88',     lat: 37.4933, lon: 126.9938, score: 4.1, comment:  7, allDay: true),
    _t(id: 111, folderIds: [1], name: '방배역 공중화장실',         address: '서울 서초구 방배로 155',      lat: 37.4815, lon: 126.9821, score: 3.7, comment:  2),
    _t(id: 112, folderIds: [1], name: '사당역 공중화장실',         address: '서울 동작구 사당로 지하 1',   lat: 37.4765, lon: 126.9815, score: 4.0, comment: 11, allDay: true,  disabled: true),

    // ── folderId 2 — 회사 근처 (ID 201~205) ──────────────────────────────
    _t(id: 201, folderIds: [2], name: '을지로입구역 공중화장실',   address: '서울 중구 을지로 29',         lat: 37.5662, lon: 126.9826, score: 4.2, comment:  5, allDay: true,  disabled: true),
    _t(id: 202, folderIds: [2], name: '시청역 공중화장실',         address: '서울 중구 세종대로 지하 1',   lat: 37.5658, lon: 126.9772, score: 4.0, comment:  3, allDay: true),
    _t(id: 203, folderIds: [2], name: '종각역 공중화장실',         address: '서울 종로구 종로 1가 지하 1', lat: 37.5700, lon: 126.9826, score: 3.9, comment:  6, allDay: true,  disabled: true),
    _t(id: 204, folderIds: [2], name: '광화문 공중화장실',         address: '서울 종로구 세종대로 172',    lat: 37.5759, lon: 126.9769, score: 4.5, comment: 12, operationTime: '07:00 ~ 21:00', disabled: true),
    _t(id: 205, folderIds: [2], name: '청계광장 공중화장실',       address: '서울 종로구 청계천로 1',      lat: 37.5698, lon: 126.9784, score: 4.3, comment:  8, operationTime: '06:00 ~ 23:00'),

    // ── folderId 3 — 집 근처 (ID 301~308) ────────────────────────────────
    _t(id: 301, folderIds: [3], name: '마포구청 공중화장실',       address: '서울 마포구 월드컵로 212',    lat: 37.5662, lon: 126.9011, score: 4.1, comment:  4, disabled: true),
    _t(id: 302, folderIds: [3], name: '홍대입구역 공중화장실',     address: '서울 마포구 양화로 188',      lat: 37.5572, lon: 126.9243, score: 4.6, comment: 20, allDay: true,  disabled: true, diaper: true),
    _t(id: 303, folderIds: [3], name: '합정역 공중화장실',         address: '서울 마포구 양화로 지하 1',   lat: 37.5499, lon: 126.9147, score: 4.0, comment:  7, allDay: true),
    _t(id: 304, folderIds: [3], name: '망원한강공원 화장실',       address: '서울 마포구 마포나루길 467',  lat: 37.5544, lon: 126.8990, score: 4.2, comment:  9, operationTime: '05:00 ~ 24:00'),
    _t(id: 305, folderIds: [3], name: '성산대교 남단 공중화장실',  address: '서울 마포구 성산로 602',      lat: 37.5527, lon: 126.8957, score: 3.8, comment:  3),
    _t(id: 306, folderIds: [3], name: '이마트 마포점 화장실',      address: '서울 마포구 마포대로 195',    lat: 37.5490, lon: 126.9027, score: 4.4, comment:  6, operationTime: '10:00 ~ 23:00', diaper: true),
    _t(id: 307, folderIds: [3], name: '공덕역 공중화장실',         address: '서울 마포구 마포대로 지하 1', lat: 37.5447, lon: 126.9514, score: 4.1, comment:  5, allDay: true,  disabled: true),
    _t(id: 308, folderIds: [3], name: '상암월드컵경기장 공중화장실', address: '서울 마포구 월드컵로 240',  lat: 37.5684, lon: 126.8976, score: 4.3, comment:  2, operationTime: '09:00 ~ 18:00', disabled: true),

    // ── folderId 5 — 공원 (ID 501~503) ───────────────────────────────────
    _t(id: 501, folderIds: [5], name: '올림픽공원 1화장실',        address: '서울 송파구 올림픽로 424',    lat: 37.5213, lon: 127.1219, score: 4.3, comment: 11, operationTime: '06:00 ~ 22:00', disabled: true),
    _t(id: 502, folderIds: [5], name: '서울숲 공중화장실',         address: '서울 성동구 뚝섬로 273',      lat: 37.5446, lon: 127.0374, score: 4.7, comment: 18, operationTime: '06:00 ~ 22:00', diaper: true, disabled: true),
    _t(id: 503, folderIds: [5], name: '한강시민공원 뚝섬지구 화장실', address: '서울 광진구 강변북로 139', lat: 37.5298, lon: 127.0652, score: 4.5, comment: 14, allDay: true),
  ];

  // ── 쿼리 헬퍼 ─────────────────────────────────────────────────────────────

  /// 주변 화장실 목록 (getNearToilet용) — 플래그 필터 + 페이지네이션
  static List<DynamicMap> getNearPage(DynamicMap query) {
    final page = (query['page'] as num?)?.toInt() ?? 0;
    final size = (query['size'] as num?)?.toInt() ?? 20;
    final filtered = _applyFlagFilter(all, query);
    final start = page * size;
    if (start >= filtered.length) return [];
    return filtered.sublist(start, (start + size).clamp(0, filtered.length));
  }

  /// 키워드 검색 목록 (searchToilet용) — 키워드 + 플래그 필터 + 페이지네이션
  static List<DynamicMap> searchPage(DynamicMap query) {
    final keyword = ((query['keyword'] as String?) ?? '').toLowerCase();
    final page    = (query['page'] as num?)?.toInt() ?? 0;
    final size    = (query['size'] as num?)?.toInt() ?? 10;

    final matched = all.where((t) {
      final name    = (t['toiletName'] as String).toLowerCase();
      final address = (t['address']    as String).toLowerCase();
      return name.contains(keyword) || address.contains(keyword);
    }).toList();

    final filtered = _applyFlagFilter(matched, query);
    final start = page * size;
    if (start >= filtered.length) return [];
    return filtered.sublist(start, (start + size).clamp(0, filtered.length));
  }

  /// ID로 단일 화장실 조회 (getToilet용)
  static DynamicMap? findById(int id) {
    for (final t in all) {
      if (t['toiletId'] == id) return t;
    }
    return null;
  }

  /// folderId로 필터링 (bookmark_mock_data_source용)
  static List<DynamicMap> getByFolderId(int folderId) =>
      all.where((t) => (t['folderId'] as List).contains(folderId)).toList();

  // ── private ────────────────────────────────────────────────────────────
  static List<DynamicMap> _applyFlagFilter(
    List<DynamicMap> source,
    DynamicMap query,
  ) {
    final allDay   = query['allDay']   as bool? ?? false;
    final disabled = query['disabled'] as bool? ?? false;
    final kids     = query['kids']     as bool? ?? false;
    final diaper   = query['diaper']   as bool? ?? false;

    return source.where((t) =>
      (!allDay   || t['allDay']    == true) &&
      (!disabled || t['dmalePee']  == true) &&
      (!kids     || t['cmalePee']  == true) &&
      (!diaper   || t['diaper']    == true)
    ).toList();
  }
}
