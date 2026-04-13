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
ex) 폴더명: screens, 파일명: login_screen.dart

폴더명은 복수형으로, 파일명은 단수형으로 작성
ex) 폴더명: screens, 파일명: login_screen.dart
```

### 2. 변수명, 함수명 : camelCase

### 3. 클래스명 : PascalCase

```c
클래스를 하나의 파일로 정리한다면 파일명과 클래스명은 동일하게 작성
ex) 파일명: login_screen.dart , 클래스명: LoginScreen
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

---

(수정 중!!!!)

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

### 4. lib/data

### 5. lib/presentation/views (<- lib/screens)

```c
화면의 UI들을 보관하는 폴더 (화면 전반 담당)
특정 기능마다 화면 분류가 필요해 질 경우, 세부 폴더가 존재할 수 있음
```

⇒ 간단한 화면인 경우 해당 폴더 안에 하나의 파일, 좀 더 복잡한 화면이라면 더 큰 위젯에 사용할 local_widgets 폴더 포함시켜 코드를 깔끔하게 유지할 수 있음

### 3. lib/widgets

```c
UI를 담당하는 위젯들을 모아두는 폴더
화면의 부분부분의 요소들 중 재사용되는 UI들을 모아둔 곳
```

### 3. lib/shared/widgets (<- lib/widgets)

### 4. lib/shared/utils (<- lib/utilities)

```c
앱에서 사용하는 function, logic을 모아두는 폴더
```

### 5. lib/presentation/view_models (<- lib/providers)

```c
앱 외부의 다른 서비스들과 앱을 연결할때 사용하는 내용들을 정리
플러터 패키지 중의 하나인 provider와 다름
```

⇒ flutter에서는 dio 라이브러리를 통신 패키지로 많이 사용

### 6. lib/models

```
데이터베이스와 데이터를 주고받기 위해 사용하는 파일들을 모아두는 폴더
(모델 : 서버, 사용자 또는 외부 API에서 제공되는 데이터의 모음)

앱 전체에서 사용되는 데이터들을 저장하는 데 사용
global 구조
```
