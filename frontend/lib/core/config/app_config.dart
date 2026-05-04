/// 앱 전역 설정 상수.
///
/// Mock 모드 활성화:
///   flutter run --dart-define=MOCK_MODE=true
const bool kMockMode = bool.fromEnvironment('MOCK_MODE', defaultValue: false);
