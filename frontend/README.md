# 화장실을 찾아서 (find_toilet) 리팩토링 - FE

## 의존성 설치

- pubspec.yaml 파일에 있는 패키지가 설치됨

```bash
flutter pub get
```

---

## [FE] convention & file structure

## 명명

### 1. 폴더명, 파일명 : snake_case

```c
폴더명과 내부 파일의 역할이 정확한 분류라면 파일의 이름에 폴더명을 추가
(적지 않아도 명확히 특정 폴더 소속임이 명확하다면 파일 이름에 폴더명 생략)
ex) 폴더명: views, 파일명: login_view.dart

폴더명은 복수형으로, 파일명은 단수형으로 작성
ex) 폴더명: views, 파일명: login_view.dart
```

### 2. 변수명, 함수명 : camelCase

### 3. 클래스명 : PascalCase

```c
클래스를 하나의 파일로 정리한다면 파일명과 클래스명은 동일하게 작성
ex) 파일명: login_view.dart , 클래스명: LoginView
```

## 파일 구조

```python
lib/
  core/                          # 프레임워크·앱 전역 횡단 관심사
    config/                      # env, 상수
    network/                     # Dio BaseOptions, 인터셉터(401 refresh), 공통 에러 타입
    di/                          # (선택) 수동 생성자 주입 헬퍼, 나중에 get_it 등으로 확장 가능
  domain/                        # 비즈니스 규칙의 “경계”
    entities/                    # (선택) 지금의 model과 동일하게 시작해도 됨
    repositories/                # 추상 Repository 인터페이스만 (예: ToiletRepository)
  data/                          # 데이터 출처 구현
    datasources/
      remote/                    # Dio 호출 단위 (ToiletRemoteDataSource 등)
      local/                     # SecureStorage, SharedPreferences 래퍼
    repositories/                # domain 인터페이스 구현체 (Remote + Local 조합)
    mappers/                     # (선택) JSON ↔ entity 매핑이 복잡해지면 분리
  presentation/                  # MVVM의 VM + View
    view_models/                 # ChangeNotifier / AsyncNotifier 등 (기존 *Provider 역할)
      auth_session_view_model.dart
      toilet_list_view_model.dart
      ...
    views/                       # Screen 위젯 (기존 screens/)
    widgets/                     # 화면 전용 위젯이 많아지면 여기로, 공통은 아래 shared로
  shared/                        # 레이어에 속하지 않는 순수 UI·유틸
    widgets/                     # 기존 lib/widgets/
    theme/                       # style 등 (기존 utilities 중 UI 관련)
    utils/                       # 기존 utilities 중 순수 함수
  main.dart
```

## 이전 구조와 비교

### 1. assets (변화 X)

```c
프로젝트 수준에 위치
앱에서 사용할 asset(로고, 아이콘, 앱 전체에서 사용되는 정적 이미지 등)들을 모아두는 폴더
안에 fonts, images, logo 등의 세부 폴더가 존재
```

⇒ assets 폴더에 저장되면, pubspec.yaml에 등록해야 함

### 2. lib/core

```markdown
앱 전역 인프라/공통 기술 요소 (여러 feature가 공통으로 쓰는 기술 코드)

**core/network/**

- Dio 생성, 공통 interceptor, 에러 변환, 인증 헤더 처리
- “기술적 공통부”만 둠 (도메인 로직 X)

**core/config/**

- 환경변수 키, 상수, 앱 전역 설정

**core/di/ (선택)**

- 객체 조립(의존성 주입) 위치
- main.dart가 비대해지는 걸 방지
```

### 3. lib/domain

```markdown
비즈니스 규칙의 경계, 가장 안정적이어야 하는 레이어, 무엇을 해야 하는가

**domain/repositories/**

- abstract class ToiletRepository 같은 인터페이스
- ViewModel은 이것만 의존

**domain/entities/ (선택)**

- UI/인프라와 독립적인 비즈니스 모델
- 처음엔 기존 models 재사용 후 점진 분리 가능
```

### 4. lib/data

```markdown
실제 데이터 접근 구현, API 스펙 변경과 저장소 변경은 data 안에서 흡수

**data/datasources/remote/**

- endpoint 호출/response 파싱의 1차 책임

**data/datasources/local/**

- secure storage/shared preferences 접근

**data/repositories/**

- remote/local 조합해 domain 인터페이스 구현
- 캐시 정책, fallback, merge 전략
```

### 5. lib/presentation/views

```markdown
사용자에게 보이는 흐름과 상태

**presentation/views/ (<- lib/screens)**

- 화면 위젯 (기존 screens)
- 가능한 한 “렌더링 + 사용자 이벤트 전달”에 집중

**presentation/view_models/ (<- lib/providers)**

- 화면 상태/액션 처리
- Repository 호출, 로딩/에러/데이터 상태 관리
```

### 6. lib/widgets

```markdown
특정 화면 전용 위젯
```

### 7. lib/shared

```markdown
특정 도메인에 묶이지 않는 재사용 자원

**shared/widgets (<- lib/widgets)**

- 공통 UI 컴포넌트

**shared/utils (<- lib/utilities)**

- 순수 함수

**shared/theme (<- lib/utilities/style.dart)**

- 스타일
```

### 8. lib/models

```markdown
데이터베이스와 데이터를 주고받기 위해 사용하는 파일들을 모아두는 폴더
(모델 : 서버, 사용자 또는 외부 API에서 제공되는 데이터의 모음)

앱 전체에서 사용되는 데이터들을 저장하는 데 사용
```
