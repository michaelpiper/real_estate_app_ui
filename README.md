# 🏡 Real Estate App UI (Dribbble Inspired)

This Flutter project is a pixel-perfect implementation of the [Real Estate App UI](https://dribbble.com/shots/23780608-Real-Estate-App) by **Kristina Spiridonova for Purrweb UI/UX Agency** on Dribbble. It faithfully recreates the sleek design, integrates real-world functionality, and adheres to clean architecture principles using `BLoC`.
---

## 🎥 Demo

https://drive.google.com/file/d/1FJtCs0hM4Pv1475UUCruvB9yyH3uJ7Zq/view?usp=sharing

## 🎥 APK
https://drive.google.com/file/d/1pFQNn3m5CBpn8g4-hcp7VobyyXetrQv0/view?usp=sharing
---

## ✨ Features & Achievements

### 🎯 Pixel-Perfect Implementation
- Downloaded and applied the **exact font** used in the original design.
- Used a **keen eye for detail** to match layouts, spacing, and colors.
- Carefully replicated **box shadows** using `BlurStyle.outer` for an authentic feel.

### 🧠 State Management with BLoC
- Implemented `flutter_bloc` to separate UI from business logic for scalability and maintainability.

### 📱 UI & UX Improvements
- Fixed major scroll/layout issues using a custom `SwipeDetector` to deliver a **seamless scroll experience** on the `HomePage`.

### 🗺️ Real Integration
- Integrated **Google Maps** to simulate real property locations and interactions.

### ⚡ Performance Optimization
- Used `precacheImage` for **network image caching**, enhancing smoothness and speed in image rendering.

---

## 📸 UI Preview

> Check out the original inspiration: [Dribbble Shot](https://dribbble.com/shots/23780608-Real-Estate-App)

https://drive.google.com/file/d/1FJtCs0hM4Pv1475UUCruvB9yyH3uJ7Zq/view?usp=sharing
---

## 🛠️ Tech Stack

- **Flutter** with **Dart**
- **flutter_bloc** for state management
- **Google Maps API**
- **Custom Gestures & Swipe Detection**
- **Image Caching**

---

## 🚀 Getting Started

```bash
git clone https://github.com/michaelpiper/real_estate_app_ui.git
# GOOGLE_API_KEY for map support
# replace {{GOOGLE_API_KEY}} in real_estate_app_ui/ios/Runner/AppDelegate.swift
# replace {{GOOGLE_API_KEY}} in real_estate_app_ui/android/app/src/main/AndroidManifest.xml

# replace {{GOOGLE_API_KEY}} in real_estate_app_ui/lib/constants.dart
cd real_estate_app_ui
flutter pub get

flutter run
```

---

## 📌 TODO

- [ ] Add backend integration for property listings
- [ ] Implement search & filtering
- [ ] Add dark mode

---

## 🙌 Credits

- UI Design by [Kristina Spiridonova for Purrweb UI/UX Agency](https://dribbble.com/purrwebui)
- Developed by **Michael Piper**

---

Let me know if you want it tailored for GitHub with badges or deployment instructions.

## Code Structure
```txt
lib/
├── core/ 
│   ├── constants/          # App constants, enums
│   ├── errors/            # Custom exceptions and failures
│   ├── network/           # Dio/HTTP client setup, interceptors
│   ├── routes/            # App routing configuration
│   ├── theme/             # App theme data
│   ├── usecases/          # Base use case class
│   └── utils/             # Extensions, helpers, validators
│
├── features/
│   ├── property/          # Already created
│   │
│   ├── authentication/    # Auth feature
│   │   ├── data/
│   │   │   ├── datasources/ # AuthRemoteDataSource
│   │   │   ├── models/     # UserModel, TokenModel
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/   # UserEntity
│   │   │   ├── repositories/ # AuthRepository
│   │   │   └── usecases/    # Login, Register, Logout, etc.
│   │   └── presentation/
│   │       ├── bloc/       # AuthBloc, AuthEvents, AuthStates
│   │       ├── pages/      # LoginPage, RegisterPage
│   │       └── widgets/    # AuthForm, SocialLoginButtons
│   │
│   ├── profile/           # User profile management
│   │   ├── data/          # ProfileDataSource
│   │   ├── domain/        # ProfileEntity, UpdateProfile
│   │   └── presentation/  # ProfileBloc, ProfilePage
│   │
│   ├── favorites/         # Saved properties
│   │   ├── data/          # FavoritesDataSource
│   │   ├── domain/        # FavoritesRepository
│   │   └── presentation/  # FavoritesBloc, FavoritesPage
│   │
│   ├── search/           # Property search
│   │   ├── data/          # SearchDataSource
│   │   ├── domain/       # SearchFilters entity
│   │   └── presentation/  # SearchBloc, FilterWidgets
│   │
│   ├── notifications/     # Push notifications
│   │   ├── data/          # NotificationsDataSource
│   │   ├── domain/        # NotificationEntity
│   │   └── presentation/ # NotificationsBloc
│   │
│   ├── messaging/         # Chat with agents
│   │   ├── data/          # ChatDataSource
│   │   ├── domain/        # MessageEntity
│   │   └── presentation/  # ChatBloc, ChatUI
│   │
│   └── map/              # Property map view
│       ├── data/          # MapDataSource
│       ├── domain/        # MapMarkerEntity
│       └── presentation/ # MapBloc, CustomMap
│
├── injection.dart        # Dependency injection setup
└── main.dart             # App entry point
```