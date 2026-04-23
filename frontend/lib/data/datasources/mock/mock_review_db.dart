import 'package:find_toilet/models/review_model.dart';
import 'package:find_toilet/shared/utils/type_enum.dart';

/// 모든 Mock 더미 리뷰 데이터의 단일 진실 공급원.
///
/// [review_form_mock_data_source.dart]가 이 DB를 사용합니다.
/// toiletId는 [MockToiletDb]의 화장실 ID와 일치하며,
/// comment 수가 많은 화장실 위주로 더미 리뷰를 구성했습니다.
///
/// reviewId 범위: 1001 ~ (toiletId와 충돌하지 않도록 1000번대 사용)
class MockReviewDb {
  MockReviewDb._();

  static const int _pageSize = 10;

  // ── 헬퍼 ─────────────────────────────────────────────────────────────────
  static DynamicMap _r({
    required int reviewId,
    required double score,
    required String comment,
    required String nickname,
  }) =>
      {
        'reviewId': reviewId,
        'score': score,
        'comment': comment,
        'nickname': nickname,
      };

  // ── toiletId별 리뷰 목록 ─────────────────────────────────────────────────
  // comment 수가 많은 화장실 위주로 구성 (MockToiletDb의 comment 필드와 연동)
  static final Map<int, List<DynamicMap>> _byToilet = {
    // ID 6 — 잠실역 공중화장실 (comment: 30)
    6: [
      _r(reviewId: 1001, score: 5.0, nickname: '잠실주민',   comment: '항상 청결하게 관리되어 있어요. 아이 데리고 오기에도 좋습니다.'),
      _r(reviewId: 1002, score: 4.0, nickname: '지나가다',   comment: '24시간 운영이라 야간에도 이용할 수 있어서 좋아요.'),
      _r(reviewId: 1003, score: 5.0, nickname: '송파구민',   comment: '기저귀 교환대도 있고 장애인 화장실도 잘 갖춰져 있네요.'),
      _r(reviewId: 1004, score: 4.0, nickname: '운동하는사람', comment: '러닝 후 자주 이용하는데 항상 깨끗해요.'),
      _r(reviewId: 1005, score: 3.0, nickname: '주말방문객', comment: '주말에는 줄이 좀 길어요. 그래도 청결 상태는 양호합니다.'),
    ],

    // ID 1 — 서울역 공중화장실 (comment: 22)
    1: [
      _r(reviewId: 1006, score: 4.0, nickname: '출장자',     comment: '지방에서 올라올 때마다 이용해요. 관리가 잘 되어 있어요.'),
      _r(reviewId: 1007, score: 5.0, nickname: '여행객',     comment: '서울역 답게 시설이 좋네요. 장애인 편의시설도 잘 갖춰져 있습니다.'),
      _r(reviewId: 1008, score: 3.0, nickname: '출근러',     comment: '아침 출근 시간대에는 많이 붐벼요.'),
      _r(reviewId: 1009, score: 4.0, nickname: '외국인도우미', comment: '외국 관광객이 많이 오는 곳이라 그런지 관리가 철저합니다.'),
    ],

    // ID 2 — 명동 공중화장실 (comment: 18)
    2: [
      _r(reviewId: 1010, score: 5.0, nickname: '명동쇼핑족', comment: '쇼핑하다 급하면 여기로 달려와요. 항상 깨끗하게 유지돼요.'),
      _r(reviewId: 1011, score: 4.0, nickname: '관광객A',    comment: '명동 한가운데 위치해서 찾기 쉬워요.'),
      _r(reviewId: 1012, score: 3.0, nickname: '주말나들이', comment: '주말엔 대기 줄이 꽤 길어요. 그래도 깨끗합니다.'),
      _r(reviewId: 1013, score: 4.0, nickname: '명동직장인', comment: '평일 점심시간에 자주 이용하는데 쾌적해요.'),
    ],

    // ID 302 — 홍대입구역 공중화장실 (comment: 20)
    302: [
      _r(reviewId: 1014, score: 5.0, nickname: '홍대카페투어', comment: '홍대에서 제일 깨끗한 화장실이에요. 기저귀 교환대도 있어요.'),
      _r(reviewId: 1015, score: 4.0, nickname: '대학생',      comment: '24시간 운영이라 야간 공연 후에도 이용할 수 있어서 좋아요.'),
      _r(reviewId: 1016, score: 5.0, nickname: '외출맘',      comment: '아이 데리고 와도 안심이에요. 시설이 정말 잘 되어 있어요.'),
      _r(reviewId: 1017, score: 4.0, nickname: '홍대방문자',  comment: '항상 비치된 물품도 넉넉하고 청결해요.'),
    ],

    // ID 502 — 서울숲 공중화장실 (comment: 18)
    502: [
      _r(reviewId: 1018, score: 5.0, nickname: '서울숲단골',  comment: '공원 화장실 치고는 정말 청결해요. 기저귀 교환대도 있고요.'),
      _r(reviewId: 1019, score: 5.0, nickname: '주말피크닉족', comment: '산책로 옆에 있어서 접근성이 좋아요. 관리 상태 최고!'),
      _r(reviewId: 1020, score: 4.0, nickname: '반려견산책러', comment: '가족 모두 이용하기 편해요. 환경도 쾌적합니다.'),
      _r(reviewId: 1021, score: 4.0, nickname: '러닝크루',    comment: '운동 후 이용하기 딱 좋아요. 시설도 좋고 깨끗합니다.'),
    ],

    // ID 503 — 한강시민공원 뚝섬지구 화장실 (comment: 14)
    503: [
      _r(reviewId: 1022, score: 5.0, nickname: '한강러닝족',  comment: '24시간 이용 가능해서 야간 러닝 때도 편해요.'),
      _r(reviewId: 1023, score: 4.0, nickname: '치맥족',      comment: '저녁에 한강 나와서 이용하기 딱 좋아요.'),
      _r(reviewId: 1024, score: 4.0, nickname: '자전거라이더', comment: '한강 자전거 도로 옆이라 자주 들러요. 항상 괜찮아요.'),
    ],

    // ID 501 — 올림픽공원 1화장실 (comment: 11)
    501: [
      _r(reviewId: 1025, score: 4.0, nickname: '올림픽공원팬', comment: '공원 규모에 비해 화장실 수가 충분해요. 관리도 잘 돼요.'),
      _r(reviewId: 1026, score: 5.0, nickname: '소풍나온가족', comment: '아이들 데리고 왔는데 시설이 좋아서 만족스러웠어요.'),
      _r(reviewId: 1027, score: 3.0, nickname: '축제방문객',  comment: '행사 기간에는 많이 붐벼요. 평소에는 괜찮습니다.'),
    ],

    // ID 101 — 강남역 공중화장실 (comment: 8)
    101: [
      _r(reviewId: 1028, score: 5.0, nickname: '강남직장인',  comment: '강남역 근처에서 제일 깨끗한 공공 화장실이에요.'),
      _r(reviewId: 1029, score: 4.0, nickname: '쇼핑객B',     comment: '24시간 운영이라 야근 후에도 이용할 수 있어 좋아요.'),
      _r(reviewId: 1030, score: 4.0, nickname: '강남방문자',  comment: '장애인 화장실도 잘 갖춰져 있어요.'),
    ],

    // ID 102 — 코엑스몰 B1 화장실 (comment: 15)
    102: [
      _r(reviewId: 1031, score: 5.0, nickname: '코엑스단골',  comment: '상업시설답게 항상 청결하게 유지돼요. 시설도 최고급이에요.'),
      _r(reviewId: 1032, score: 4.0, nickname: '전시관람객',  comment: '전시 관람 중에 이용했는데 넓고 쾌적해요.'),
      _r(reviewId: 1033, score: 5.0, nickname: '쇼핑마니아',  comment: '코엑스몰에서 쇼핑할 때 꼭 들르는 곳이에요. 항상 좋아요.'),
    ],

    // ID 204 — 광화문 공중화장실 (comment: 12)
    204: [
      _r(reviewId: 1034, score: 5.0, nickname: '광화문직장인', comment: '관리가 정말 잘 되어 있어요. 장애인 편의시설도 좋습니다.'),
      _r(reviewId: 1035, score: 4.0, nickname: '광화문관광객', comment: '관광지 근처라 그런지 항상 깔끔하게 유지돼요.'),
      _r(reviewId: 1036, score: 3.0, nickname: '집회참가자',  comment: '행사 때는 줄이 매우 길어요. 평소에는 쾌적합니다.'),
    ],

    // ID 108 — 고속터미널역 공중화장실 (comment: 9)
    108: [
      _r(reviewId: 1037, score: 5.0, nickname: '터미널이용자', comment: '기저귀 교환대에 장애인 시설까지. 모든 게 잘 갖춰져 있어요.'),
      _r(reviewId: 1038, score: 4.0, nickname: '버스이용객',  comment: '24시간 운영이라 새벽 버스 탈 때도 이용할 수 있어요.'),
    ],
  };

  // reviewId → review 조회용 인덱스 (자동 생성)
  static final Map<int, DynamicMap> _byReviewId = {
    for (final reviews in _byToilet.values)
      for (final r in reviews)
        (r['reviewId'] as int): r,
  };

  // ── public API ────────────────────────────────────────────────────────────

  /// toiletId에 속한 리뷰를 페이지네이션하여 반환합니다.
  static List<ReviewModel> getByToilet(int toiletId, int page) {
    final all = _byToilet[toiletId] ?? [];
    final start = page * _pageSize;
    if (start >= all.length) return [];
    return all
        .sublist(start, (start + _pageSize).clamp(0, all.length))
        .map((json) => ReviewModel.fromJson(json))
        .toList();
  }

  /// toiletId에 속한 총 페이지 수를 반환합니다.
  static int totalPagesFor(int toiletId) {
    final count = (_byToilet[toiletId] ?? []).length;
    return count == 0 ? 0 : (count / _pageSize).ceil();
  }

  /// reviewId로 단일 리뷰를 조회합니다.
  static ReviewModel? findById(int reviewId) {
    final json = _byReviewId[reviewId];
    return json != null ? ReviewModel.fromJson(json) : null;
  }
}
