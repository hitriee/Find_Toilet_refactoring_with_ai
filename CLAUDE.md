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

Provider-based state management. Key providers in `lib/providers/`:

- `StateProvider` — Primary app state (map state, active filters, toilet list)
- `ApiProvider` — All HTTP calls via Dio
- `UserProvider` — Auth state and user profile
- `ToiletProvider`, `BookmarkProvider`, `ReviewProvider` — Domain-specific state

Screens in `lib/screens/`, reusable components in `lib/widgets/`, data models in `lib/models/`.

Maps are rendered with Kakao Maps SDK. Location is resolved via `geolocator`. Navigation between pages goes through `StateProvider` rather than direct route pushes in many cases.

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
