요청대로 먼저 flutter-mvvm-arch.mdc 규칙 내용을 확인한 다음, frontend/lib 코드에서 그 규칙 위반 지점을 찾아 필요한 리팩터링/정리까지 진행할게요. 우선 규칙 파일부터 읽고 기준을 확정하겠습니다.

규칙은 View(presentation/views)는 UI만, ViewModel(presentation/viewmodels)은 상태+Repository 통신, Repository는 interface/impl 분리, 그리고 View에서 네트워크/Repository 직접 접근 금지라는 내용이라 이해했어요. 이제 frontend/lib에서 이 조건을 깨는 지점을 빠르게 탐지(특히 presentation/views 쪽)한 뒤, 위반이 확인된 파일만 MVVM 흐름대로 고치겠습니다.

presentation/views 쪽은 검색 패턴이 잘 안 걸렸을 수 있어서, 실제 뷰 파일 목록을 확인했어요. 다음으로는 규칙 위반 가능성이 큰 지점(뷰/뷰모델/리포지토리 구현)을 바로 확인하기 위해 관련 Dart 파일들을 읽어보고, 위반이 있으면 그 파일들만 MVVM 구조에 맞게 고치겠습니다.

지금 확인해보니 presentation/views와 review_form_screen.dart에서 ReviewProvider 같은 네트워크 계열 호출을 직접 하고 있어서, 규칙의 “View는 ViewModel 경유, 네트워크는 ViewModel/Repository 경유”를 어기고 있는 상태로 보입니다. 다음 단계로는 presentation/views와 presentation/view_models에서 직접 \*Provider 호출/dio/repository 구현 직접참조가 있는 곳을 전부 탐지한 뒤, 영향이 큰 파일부터 ViewModel로 위임하도록 수정하겠습니다.

스캔 결과 presentation/views 안에서 네트워크/프로바이더 직접 접근이 있는 파일이 최소 3개(review_form_screen.dart, book_mark_folder_screen.dart, intro_view.dart)로 확인됐어요. 이제 이 파일들부터 View가 네트워크 호출을 직접 하지 않도록 ViewModel로 위임하는 리팩터링을 진행하겠습니다(나머지 뷰는 일단 규칙 위반이 더 명확한 부분 위주로 후속 처리).

현재 규칙 위반 수정이 필요하다고 판단된 뷰/네트워크 호출 흐름을 파악하기 위해, 먼저 frontend/lib 디렉터리 구조와 실제로 providers/\*가 존재하는지 확인하고(참조 경로가 import와 일치해야 리팩터링이 안전합니다), 그 다음 intro_view, review_form_screen, book_mark_folder_screen을 ViewModel 위임 형태로 고치겠습니다.

이제 실제 리팩터링을 시작할게요. 우선 규칙에 맞게 presentation/view_models에 IntroViewModel, ReviewFormViewModel, BookmarkFolderViewModel을 새로 추가하고, 기존 intro_view, review_form_screen, book_mark_folder_screen에서 UserProvider/ReviewProvider/FolderProvider를 직접 호출하던 부분을 ViewModel로 위임하겠습니다. 이후 import 경로도 providers/* 오타가 보이는 부분을 core/network/*로 정리해서 빌드가 깨지지 않게 하겠습니다.

다음은 review_form_screen.dart을 규칙에 맞게 바꾸겠습니다. 화면(StatefulWidget)에서 ReviewProvider 네트워크 호출/에러 처리를 제거하고, 새로 만든 ReviewFormViewModel이 init/load/submit을 담당하도록 구조를 옮길게요. 이렇게 하면 View는 입력/레이아웃 + 모달 표시만 남습니다.

review_form_screen.dart는 ViewModel로 네트워크 호출을 옮기는 과정에서, 남아있는 reviewData 참조 1곳(reviewScore()의 별 색 계산)이 아직 남아있어서 컴파일 오류가 날 수 있어요. 해당 부분을 \_viewModel.reviewData 기반으로 수정하고, 빌드에서 더 이상 필요 없는 로컬 변수도 제거하겠습니다.

이제 book_mark_folder_screen.dart도 View가 FolderProvider().getFolderList()를 직접 호출하지 않도록 바꿉니다. StatelessWidget을 Statefull로 전환해서 BookmarkFolderViewModel이 폴더 목록을 로딩하고, 화면은 FutureBuilder로 결과만 렌더링하게 하겠습니다.

다음 단계로는 아직 남아있는 package:find_toilet/providers/... 잘못된 import들을 모두 package:find_toilet/core/network/...로 정리하겠습니다. 이 작업은 지금 추가한 ViewModel/수정한 View들이 실제 네트워크 Provider 클래스를 올바른 경로에서 찾도록 만들기 위한 기반 정리입니다.

네트워크 계층 파일(core/network/\*\_provider.dart)과 상태/유틸 파일에서 남아 있던 package:find_toilet/providers/... 잘못된 import들을 package:find_toilet/core/network/...로 교체하는 작업을 진행 중입니다. 이제 state_provider.dart, global_utils.dart, bottom_sheet.dart, modal.dart까지 동일하게 정리해서 providers 경로 잔여가 없게 만들겠습니다.

네트워크 계층 쪽과 shared/utils/widgets에 남아있던 package:find_toilet/providers/... 경로 오타를 모두 core/network/...로 바꾸는 작업을 계속했습니다. 이제 전체 frontend/lib에서 더 이상 providers/ 경로가 남아있는지 재검색해서 확인하겠습니다.

flutter analyze가 샌드박스/권한 제약 때문에(Flutter 엔진 버전 stamp 파일 기록) 실패했어요. 실제 코드 컴파일 상태를 확인하려면 샌드박스를 풀고 다시 flutter analyze를 돌리겠습니다.

frontend/lib에서 .cursor/rules/flutter-mvvm-arch.mdc의 핵심(“네트워크/비즈니스 로직은 ViewModel로 이동, View는 ViewModel을 통해 상태/동작만 연결”)에 맞게, 직접 UserProvider/ReviewProvider/FolderProvider 같은 네트워크 호출을 View에서 하던 부분을 ViewModel로 옮겼습니다.

### 적용/리팩터링 내용

- 새 ViewModel 추가
  - frontend/lib/presentation/view_models/intro_view_model.dart
  - frontend/lib/presentation/view_models/review_form_view_model.dart
  - frontend/lib/presentation/view_models/bookmark_folder_view_model.dart
- View 수정(네트워크 호출 제거, ViewModel 경유)
  - frontend/lib/presentation/views/intro_view.dart : IntroViewModel.preparation()로 자동로그인/토큰 초기화 위임
  - frontend/lib/presentation/views/review_form_screen.dart : ReviewFormViewModel로 로딩/등록-수정 submit 로직 위임
  - frontend/lib/presentation/views/book_mark_folder_screen.dart : BookmarkFolderViewModel.loadFolders()로 폴더 목록 로딩 위임
- (부수 정리) 잘못된 import 경로 package:find_toilet/providers/...를 package:find_toilet/core/network/...로 정리
  - core/network/\*\_provider.dart, presentation/view_models/state_provider.dart, shared/utils/global_utils.dart, shared/widgets/bottom_sheet.dart, shared/widgets/modal.dart

### 현재 상태(분석 결과 요약)

- flutter analyze는 다수의 기존 문제(예: SettingsProvider, MainSearchProvider, ScrollProvider 같은 타입명이 실제 코드에 정의돼 있지 않은 불일치)가 보여서 “전체 컴파일/완전한 규칙 준수”를 여기서 한 번에 끝내긴 어렵습니다.
- 다만, 이번 변경으로 적어도 presentation/views 중 intro/review_form/book_mark_folder는 View에서 네트워크 Provider를 직접 호출하던 흐름을 제거하고 ViewModel로 옮긴 상태입니다.

원하시면 다음으로, 규칙을 “실제로 빌드/런타임까지” 맞추기 위해 Provider vs ViewModel 네이밍 불일치(예: SettingsProvider/SettingsViewModel)를 일괄 정리해서 규칙 적용 범위를 더 넓혀드릴까요?
