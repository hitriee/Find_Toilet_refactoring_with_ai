---
name: Cursor Convention Rules
overview: Add Cursor rules for coding conventions with an always-applied core rule and layered Dart rules for domain/data/presentation concerns.
todos:
  - id: define-core-rule
    content: Create an always-applied core convention rule with naming, architecture boundary, error handling, and async/state conventions
    status: pending
  - id: define-layered-rules
    content: Create separate domain/data/presentation rule files with layer-specific boundaries and responsibilities
    status: pending
  - id: add-examples
    content: Add concise BAD/GOOD examples in each rule to make enforcement concrete
    status: pending
isProject: false
---

# Cursor Rules 작성 가이드

## 목표

프로젝트 코드 컨벤션을 Cursor가 일관되게 참조하도록 `.cursor/rules/`에 룰을 분리 작성합니다.

## 권장 구조

- 공통 원칙은 항상 적용 1개 파일로 유지
- 레이어별 컨벤션은 Dart 파일 대상 규칙으로 분리

권장 파일:

- `.cursor/rules/core-conventions.mdc` (alwaysApply: true)
- `.cursor/rules/domain-conventions.mdc` (globs: `frontend/lib/domain/**/*.dart`)
- `.cursor/rules/data-conventions.mdc` (globs: `frontend/lib/data/**/*.dart`)
- `.cursor/rules/presentation-conventions.mdc` (globs: `frontend/lib/presentation/**/*.dart`)

## 각 룰 파일 템플릿

```md
---
description: Core coding conventions for Find_Toilet frontend
alwaysApply: true
---

# Core Conventions

## Naming

- Folder/file: snake_case
- Class: PascalCase
- Variables/functions: camelCase

## Architecture Boundaries

- domain은 구현 의존성(Dio, Provider, storage)을 직접 참조하지 않는다.
- data는 datasource + repository impl 책임만 가진다.
- presentation(view_model/view)은 repository interface에 의존한다.

## Error Handling

- `throw Error()` 금지, 의미 있는 `Exception` 사용
- catch에서 원인 메시지/컨텍스트를 유지한다

## Async/State

- ViewModel에서 상태 변경 시점만 `notifyListeners()` 호출
- 네트워크 호출은 View에서 직접 수행하지 않고 ViewModel/Repository를 통해 수행
```

레이어별 파일은 동일한 frontmatter 형식을 쓰고, 본문만 책임에 맞게 좁혀 작성합니다.

## 레이어별 핵심 문구 예시

- domain:
  - `abstract repository interface only`
  - 비즈니스 규칙/계약 중심, 구현/HTTP 코드 금지
- data:
  - remote/local datasource에서 I/O 처리
  - repository impl은 매핑/조합/예외 변환 담당
- presentation:
  - View는 렌더링/이벤트 전달 중심
  - ViewModel은 상태 + use-case orchestration

## 작성 원칙

- 한 파일 30~50줄 내외
- 규칙당 하나의 관심사
- 반드시 BAD/GOOD 예시 1개 이상 포함
- 모호한 표현(가능하면, 적당히) 대신 금지/권장 문장 사용
