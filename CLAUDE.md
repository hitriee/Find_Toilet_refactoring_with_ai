# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Find Toilet (화장실을 찾아서)** — A location-based public restroom finder app. Users can find nearby toilets via GPS, filter by facilities (disability access, child facilities, diaper changing, 24h operation), bookmark favorites, and write reviews. Published on Google Play Store.

## Repository Structure

- `backend/` — Spring Boot 2.7.8 (Java 11) REST API
- `frontend/` — Flutter mobile app (Dart ≥2.19)

## Backend Commands

```bash
cd backend

# Run locally
./gradlew bootRun

# Build JAR
./gradlew build

# Run all tests
./gradlew test

# Run a single test class
./gradlew test --tests com.Fourilet.project.fourilet.<TestClassName>

# Build Docker image
docker build -t fourilet-backend .
```

Database connection is configured in `src/main/resources/application.yml` pointing to a remote MySQL instance. Hibernate DDL is set to `update`, so the schema auto-migrates on startup.

Swagger UI is available at `/swagger-ui/` when running locally.

## Frontend Commands

```bash
cd frontend

# Install dependencies
flutter pub get

# Run app (requires connected device or emulator)
flutter run

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Static analysis / lint
flutter analyze

# Build Android APK
flutter build apk
```

## Architecture

### Backend

Layered REST API following Controller → Service → Repository:

- **Controllers** (`controller/`): `MemberController`, `ToiletController`, `ReviewController`, `FolderController`, `OAuthController`
- **Services** (`service/`): Business logic per entity
- **Data** (`data/`): JPA entities (`Member`, `Toilet`, `Review`, `Folder`, `BookMark`) and Spring Data repositories
- **DTOs** (`dto/`): Request/response objects, separate from entities
- **Config** (`config/`): JWT filter, Spring Security, Swagger, QueryDSL
- **Exception** (`exception/`): Custom exception types and global handler

Authentication uses JWT (24h access token, 14d refresh token) via Kakao OAuth2. All secured endpoints expect a Bearer token.

### Frontend

MVVM + Repository 패턴 기반의 feature-first 구조. Provider로 상태 관리.

#### 디렉토리 구조

```
lib/
├── main.dart
├── core/                          # 앱 전역 공유 코드
│   ├── config/                    # 글로벌 상태 및 설정
│   │   ├── app_config.dart        # kMockMode 플래그 정의
│   │   ├── state_provider.dart    # UserInfoProvider, ApplyChangeProvider (앱 루트 등록)
│   │   ├── settings_view_model.dart  # SettingsProvider (폰트·반경·확대버튼 앱 전역 상태)
│   │   ├── main_search_provider.dart
│   │   ├── scroll_provider.dart
│   │   └── review_bookmark_view_model.dart
│   ├── network/                   # Dio 기반 API 클라이언트
│   │   ├── api_provider.dart      # 베이스 HTTP 클라이언트 (토큰 인터셉터 포함)
│   │   ├── user_provider.dart     # 카카오 로그인, 회원 탈퇴, 닉네임 변경
│   │   ├── bookmark_provider.dart
│   │   ├── review_provider.dart
│   │   └── toilet_provider.dart
│   ├── utils/                     # 공유 유틸리티
│   │   ├── global_utils.dart      # BuildContext 기반 글로벌 헬퍼 함수
│   │   ├── type_enum.dart         # 공통 타입 별칭 (DynamicMap, FutureBool 등)
│   │   ├── style.dart             # 색상, 폰트 크기 상수
│   │   ├── icon_image.dart        # 아이콘 경로 상수
│   │   ├── settings_utils.dart    # 개인정보처리방침, 이메일 본문 등 정적 콘텐츠
│   │   ├── utils.dart
│   │   ├── tile_servers.dart
│   │   └── viewport_painter.dart
│   ├── widgets/                   # 공유 재사용 위젯
│   │   ├── modal.dart, button.dart, text_widget.dart 등
│   ├── data/                      # 앱 전역 공유 Repository 구현체 (toilet)
│   │   ├── toilet_repository_impl.dart
│   │   └── toilet_mock_repository_impl.dart
│   └── domain/                    # 앱 전역 공유 도메인 (toilet)
│       ├── toilet_model.dart
│       └── toilet_repository.dart
├── datasources/                   # 기능 간 공유 DataSource
│   ├── local/                     # SharedPreferences 등 기기 내부 저장소
│   │   └── select_theme_local_data_source.dart
│   ├── remote/                    # 서버 API 호출 DataSource
│   │   ├── toilet_remote_data_source.dart
│   │   ├── bookmark_remote_data_source.dart
│   │   ├── bookmark_folder_remote_data_source.dart
│   │   ├── review_form_remote_data_source.dart
│   │   ├── settings_remote_data_source.dart
│   │   └── intro_remote_data_source.dart
│   └── mock/                      # 더미 데이터 (kMockMode=true 시 사용)
│       ├── mock_toilet_db.dart    # 화장실 더미 데이터 단일 진실 공급원
│       ├── mock_review_db.dart    # 리뷰 더미 데이터 단일 진실 공급원
│       ├── toilet_mock_data_source.dart
│       ├── bookmark_mock_data_source.dart
│       ├── bookmark_folder_mock_data_source.dart
│       ├── review_form_mock_data_source.dart
│       └── settings_mock_data_source.dart
└── pages/                         # 기능별 페이지 (feature-first)
    ├── <feature>/
    │   ├── <feature>_page.dart    # DI 진입점: kMockMode 분기로 Repository 주입
    │   ├── data/                  # Repository 구현체
    │   │   ├── <feature>_repository_impl.dart
    │   │   └── <feature>_mock_repository_impl.dart
    │   ├── domain/                # 추상 인터페이스 및 모델
    │   │   ├── <feature>_repository.dart
    │   │   └── <feature>_model.dart
    │   └── presentation/          # ViewModel + View
    │       ├── <feature>_view_model.dart
    │       └── <feature>_view.dart
    │
    ├── intro/       # GPS 권한 요청, 자동 로그인
    ├── main/        # 지도 화면 (data·domain은 core/ 공유분 사용)
    ├── search/      # 화장실 검색 (data·domain은 core/ 공유분 사용)
    ├── select_theme/  # 글자 크기 테마 선택 (mock repository 없음 — 로컬 저장만)
    ├── bookmark_folder/  # 즐겨찾기 폴더 관리
    ├── bookmark/    # 폴더별 즐겨찾기 목록
    ├── review_form/ # 리뷰 작성·수정
    └── settings/    # 앱 설정, 로그인, 문의하기
```

#### 데이터 흐름

```
DataSource (remote / local / mock)
  → RepositoryImpl (implements Repository 인터페이스)
    → ViewModel (ChangeNotifier)
      → View (StatelessWidget, context.watch / context.read)
```

Page는 DI 진입점 역할만 하며 `kMockMode`에 따라 Mock 또는 Real Repository를 주입한다.
View와 ViewModel은 mock 존재를 모른다.

#### 글로벌 Provider (앱 루트 등록)

`main.dart`의 `MultiProvider`에 앱 전체 생명주기 동안 유지되는 Provider를 등록한다.

| Provider | 역할 |
|---|---|
| `UserInfoProvider` | JWT 토큰·닉네임 (FlutterSecureStorage 연동) |
| `SettingsProvider` | 폰트 크기·지도 반경·확대버튼 (SharedPreferences 연동) |
| `ApplyChangeProvider` | 뒤로가기 처리 |
| `ScrollProvider` | 지도 스크롤 상태 |
| `ReviewBookMarkProvider` | 리뷰·즐겨찾기 목록 상태 |
| `MainSearchProvider` | 메인 화면 검색 상태 |

#### Mock 모드

백엔드 없이 UI를 확인할 때 사용한다.

```bash
# Mock 모드로 실행
flutter run --dart-define=MOCK_MODE=true

# Mock 모드로 APK 빌드
flutter build apk --dart-define=MOCK_MODE=true
```

`kMockMode`(`lib/core/config/app_config.dart`)가 `true`이면 각 Page에서 `*MockRepositoryImpl`을 주입한다.
더미 데이터의 단일 진실 공급원은 `MockToiletDb`(화장실)와 `MockReviewDb`(리뷰)이며,
다른 mock DataSource들은 이 두 DB를 참조한다.

### Data Model Core

`Toilet` has boolean facility flags (`disabledPerson`, `kids`, `diaper`, `allDay`), coordinates, operating hours, and a relationship to `Review`. `BookMark` links `Member` → `Folder` → `Toilet`.

## Tech Stack

| Layer | Technology |
|---|---|
| Backend runtime | Java 11, Spring Boot 2.7.8, Gradle |
| ORM | JPA/Hibernate, QueryDSL |
| Auth | Spring Security, JWT (jjwt), Kakao OAuth2 |
| Database | MySQL (remote AWS host) |
| Mobile | Flutter/Dart, Provider, Dio, Kakao Maps |
| Deployment | Docker, AWS EC2, Jenkins |
