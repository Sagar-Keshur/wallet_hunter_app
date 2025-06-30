# Wallet Hunter App

A comprehensive Flutter family management application built with modern architecture and state management. This app helps families organize member information, create family trees, and manage family relationships with a beautiful and intuitive interface.

## 🚀 Features

### Authentication & Onboarding

- **OTP-based Authentication**: Secure mobile number verification
- **Complete Onboarding Flow**: 4-step registration process
  - Personal Information (Name, Age, Gender, Birth Date)
  - Contact Information (Phone, Email, Landline)
  - Address Details (Current Address with Pincode)
  - Profile Summary
- **Samaj Integration**: Community-based temple associations

### Family Management

- **Family Member Registration**: Add new family members with detailed information
  - Personal Information
  - Relation with Family Head
  - Contact Information
  - Current Address
  - Native Place
  - Profile Photos
- **Dynamic Dashboard**: Real-time family member display
- **Family Tree Visualization**: Hierarchical family structure display
- **Member Management**: Add, view, and delete family members (Family Head only)

### Advanced Features

- **Photo Management**: Camera and gallery integration
- **Screenshot & Share**: Export family tree as images
- **Responsive Design**: Works on all screen sizes
- **Modern UI/UX**: Material Design with custom styling

## 🛠 Tech Stack

- **Framework**: Flutter 3.8.1+
- **State Management**: MobX with Provider
- **Backend**: Firebase (Auth, Firestore, Storage, Analytics, Crashlytics)
- **Architecture**: Clean Architecture with Dependency Injection
- **UI**: Material Design with custom Lato font family
- **Permissions**: Runtime permission handling
- **Image Processing**: Image picker with camera/gallery support

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.8.1 or higher
- Dart SDK
- Android Studio / VS Code
- iOS Simulator (for iOS development)
- Android Emulator or physical device

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/Sagar-Keshur/wallet_hunter_app.git
   cd wallet_hunter_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate code**

   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Firebase Setup

1. Create a new Firebase project
2. Add Android and iOS apps to your Firebase project
3. Download and place the configuration files:
   - `google-services.json` in `android/app/`
   - `GoogleService-Info.plist` in `ios/Runner/`
4. Enable Authentication, Firestore, and Storage in Firebase Console

## 📁 Project Structure

```
lib/
├── core/
│   ├── enum/           # App enums
│   ├── exceptions/     # Custom exceptions
│   ├── models/         # Data models
│   ├── services/       # Network and utility services
│   ├── stores/         # MobX stores
│   ├── style_guide/    # App theming and styling
│   ├── utils/          # Utility functions
│   └── widgets/        # Reusable widgets
├── dependency_manager/ # Dependency injection
├── features/           # Feature-based modules
│   ├── add_member/     # Family member registration
│   ├── auth_guard/     # Route protection
│   ├── Authentication/ # Login and OTP
│   ├── dashboard/      # Main dashboard
│   ├── onboarding/     # User onboarding
│   └── splash_screen/  # App splash
├── firebase_options.dart
├── main.dart
└── router/             # App routing
```

## 🔧 Configuration

### Permissions

The app automatically handles permissions for:

- Camera access
- Photo library access
- Storage access
- Internet connectivity

## 🎨 Customization

### Styling

- Colors: Defined in `lib/core/style_guide/colors.dart`
- Typography: Lato font family with various weights
- Spacing: Consistent spacing system
- Theme: Material Design with custom overrides

### Adding New Features

1. Create feature folder in `lib/features/`
2. Add corresponding store in `lib/core/stores/`
3. Update routing in `lib/router/`
4. Add any new dependencies to `pubspec.yaml`

## 📦 Dependencies

### Core Dependencies

- `firebase_core`, `firebase_auth`, `cloud_firestore` - Firebase services
- `mobx`, `flutter_mobx` - State management
- `provider` - Dependency injection
- `image_picker` - Photo selection
- `screenshot`, `share_plus` - Export functionality
- `permission_handler` - Runtime permissions

### Development Dependencies

- `build_runner` - Code generation
- `mobx_codegen` - MobX code generation
- `json_serializable` - JSON serialization
- `lint`, `flutter_lints` - Code quality
