---
trigger: always_on
---

# Project Instructions: Doctor Hunt App

## 1. Project Overview & Architecture
- **Type**: Flutter Mobile App for doctor discovery, booking, and administrative management.
- **Root Directory**: `d:/flutter-projects/doctor_hunt_app`
- **Pattern**: Feature-first Modular Clean Architecture:
  - `lib/core/`: Common components, services, theme, routing, and utilities.
  - `lib/features/common/`: Shared user flows (`auth`, `choose_role`, `onboarding`, `splash`).
  - `lib/features/patient/`: Patient-specific screens (`home`, `doctor_details`, `find_doctors`, `favorite`, `select_time_and_date`).
  - `lib/features/admin/`: Admin features (`admin_doctor_details`, `doctors_list`, `create-doctor`, `edit_doctor`).
  - `lib/generated/` & `lib/i18n/`: Code-generated assets, text styles, and localization.

## 2. Core Technical Stack & Rules
- **State Management**:
  - Always use `flutter_bloc` for feature state management.
  - Separate events and states into distinct classes extending `Equatable`.
  - **DO NOT** use `Cubit` under any circumstances in this project.
  - **Accessing BLoCs**: Evaluate the context and choose the most appropriate method for providing and accessing BLoCs (e.g., decide between `getIt<T>()`, `BlocProvider`, etc., based on what is best for the specific use case).
- **Dependency Injection**:
  - Register new services, repositories, and BLoCs in `lib/core/services/di.dart`.
  - Use `lazySingleton` for stateless services/repositories and `factory` for BLoCs where appropriate.
- **Navigation & Routing**:
  - Use type-safe routes with `go_router_builder` defined in `lib/core/routing/routes.dart`.
  - Run `dart run build_runner build --delete-conflicting-outputs` after modifying routes.
- **Styling & Responsive UI (STRICT RULES)**:
  - **DO NOT** use `flutter_screenutil` under any circumstances (no `.w`, `.h`, `.sp`, `.r`). Use standard Flutter sizing.
  - **Colors**: ALWAYS use the `AppColors` class (`lib/core/theme/app_colors.dart`). **NEVER** use hardcoded colors like `Colors.red`, `Colors.white`, or `Color(0xFF...)`.
  - **Text Styles**: ALWAYS use the generated text styles from the project's specific generation script (e.g., from `generate_styles.dart`). **NEVER** use standard `TextStyle()` inside UI widgets. 
**Strictly avoid** using `lib/generated/app_text_styles.dart` directly if it conflicts with the project's established generated styles convention.
- **Localization (i18n) & Texts**:
  - **NO HARDCODED TEXTS**: Never put hard-coded strings in the UI. Always use localization keys.
  - Manage strings in `lib/i18n/strings.i18n.json`.
  - Generate translation classes using `slang` (`dart run slang`).
- **Backend & Remote Services**:
  - Use `FirebaseAuth` and `FirebaseFirestore` via dependency injection.
  - Image uploads should go through `CloudinaryServices` (`lib/core/services/cloudinary_services.dart`).

## 3. Code Conventions & Quality Guidelines
- Follow Effective Dart and rules in `analysis_options.yaml`.
- Prefer `const` constructors wherever possible.
- Avoid business logic inside UI/Widget files; delegate to BLoC and Repositories.
- Handle loading, error, and empty states explicitly across all screens.

## 4. Key CLI Commands
- Fetch dependencies: `flutter pub get`
- Run code generation: `dart run build_runner build --delete-conflicting-outputs`
- Run slang translations: `dart run slang`
- Static analysis: `flutter analyze`
- Run app: `flutter run`