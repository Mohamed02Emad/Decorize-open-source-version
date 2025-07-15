# Decorizer 🎨

A comprehensive Flutter application for interior design and decoration services, connecting users with professional decorators and providing AI-powered design tools.

## 📱 Overview

Decorizer is a modern mobile application that revolutionizes the interior design industry by:
- Connecting users with professional decorators
- Providing AI-powered design suggestions
- Enabling real-time collaboration through chat
- Offering order management and project tracking
- Supporting multiple languages (Arabic & English)

## ✨ Demo

### For Users
- **AI Design Assistant**: Upload images and get AI-powered design suggestions
- **Professional Network**: Browse and hire qualified decorators
- **Project Management**: Create, track, and manage decoration projects
- **Real-time Chat**: Communicate directly with decorators
- **Order System**: Post requirements and receive offers from decorators
- **Portfolio Gallery**: Browse decorator portfolios and previous work
- **Multi-language Support**: Arabic and English localization

### For Decorators/Workers
- **Profile Management**: Showcase portfolio and expertise
- **Order Management**: View and respond to user requests
- **Offer System**: Submit competitive bids for projects
- **Communication Tools**: Chat with clients
- **Rating System**: Build reputation through client feedback

## 🛠️ Tech Stack

- **Framework**: Flutter 3.29.2
- **Language**: Dart 3.5.0+
- **Architecture**: Clean Architecture with MVVM pattern
- **State Management**: BLoC/Cubit
- **Dependency Injection**: GetIt + Injectable
- **Networking**: Dio with custom interceptors
- **Local Storage**: SharedPreferences
- **Maps**: Google Maps
- **Notifications**: Firebase Cloud Messaging
- **Real-time**: Pusher Channels
- **Localization**: Easy Localization

## 📋 Prerequisites

- Flutter 3.29.2 (managed via FVM)
- Dart SDK 3.5.0+
- Android Studio / VS Code
- Xcode (for iOS development)
- FVM (Flutter Version Management)

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/decorizer.git
cd decorizer
```

### 2. Install FVM and Flutter Version
```bash
# Install FVM globally
dart pub global activate fvm

# Install and use Flutter 3.29.2
fvm install 3.29.2
fvm use 3.29.2
```

### 3. Install Dependencies
```bash
fvm flutter pub get
```

### 4. Configuration Setup

#### Firebase Configuration
1. Create a new Firebase project
2. Add Android and iOS apps to your Firebase project
3. Download and replace the configuration files:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`
4. Update `lib/firebase_options.dart` with your Firebase project details

#### API Configuration
Update the following files with your API endpoints:

**Main API Base URL** (`lib/common/util/api_basehelper.dart`):
```dart
_baseUrl = 'https://your-api-domain.com';
```

**AI Service URL** (`lib/user/create_design/data/create_design_urls.dart`):
```dart
static String aiBaseUrl = 'https://your-ai-service-domain.com';
```

#### Pusher Configuration
Update `lib/common/di/injection_container.dart`:
```dart
await pusher.init(
  apiKey: "your-pusher-api-key",
  cluster: "your-cluster",
  // ... other config
  const secret = 'your-pusher-secret';
  const key = 'your-pusher-key';
);
```

#### Google Maps API
1. Get API keys from Google Cloud Console
2. Update Android configuration in `android/app/src/main/AndroidManifest.xml`:
```xml
<meta-data android:name="com.google.android.geo.API_KEY" android:value="YOUR_ANDROID_API_KEY"/>
```
3. Update iOS configuration in `ios/Runner/AppDelegate.swift`:
```swift
GMSServices.provideAPIKey("YOUR_IOS_API_KEY")
```

### 5. Generate Code
```bash
fvm flutter packages pub run build_runner build
```

### 6. Run the Application
```bash
fvm flutter run
```

## 📁 Project Structure

```
lib/
├── common/                 # Shared utilities, widgets, and services
│   ├── app/               # App initialization and configuration
│   ├── base/              # Base classes for architecture
│   ├── constant/          # App constants and validators
│   ├── data/              # Data layer utilities
│   ├── di/                # Dependency injection setup
│   ├── resources/         # Generated resources and localization
│   ├── theme/             # App theming and colors
│   ├── util/              # Utility classes
│   └── widget/            # Reusable widgets
├── shared_features/        # Features shared between user types
│   ├── auth/              # Authentication module
│   ├── chat/              # Chat functionality
│   ├── more/              # Settings and more options
│   ├── notifications/     # Notification handling
│   └── static/            # Static data (governorates, cities, etc.)
├── user/                  # User-specific features
│   ├── bottom_navigation/ # User navigation
│   ├── create_ad/         # Create decoration requests
│   ├── create_design/     # AI design tools
│   ├── edit_profile/      # Profile management
│   ├── home/              # User dashboard
│   ├── orders/            # Order management
│   └── saved_designs/     # Saved design collections
└── worker/                # Decorator/Worker features
    ├── bottom_navigation/ # Worker navigation
    ├── home/              # Worker dashboard
    ├── offers/            # Offer management
    └── profile/           # Worker profile
```

## 🧪 Testing

Run tests:
```bash
fvm flutter test
```

## 📦 Building

### Android
```bash
# Debug APK
fvm flutter build apk --debug

# Release APK
fvm flutter build apk --release

# App Bundle for Play Store
fvm flutter build appbundle --release
```

### iOS
```bash
fvm flutter build ios --release
```

## 🌐 Localization

The app supports Arabic and English languages. Localization files are located in:
- `assets/translations/ar.json`
- `assets/translations/en.json`

To add new translations or modify existing ones, update the JSON files and regenerate the keys:
```bash
fvm flutter pub run easy_localization:generate -S "assets/translations" -O "lib/common/resources/gen" -o "locale_keys.g.dart" -f keys
```

## 🚢 Deployment

### Android (Google Play Store)
The project includes GitHub Actions workflow for automated deployment to Google Play Store. Configure the following secrets in your repository:
- `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`: Service account JSON for Play Store API

### iOS (App Store)
Manual deployment through Xcode or configure Fastlane for automated deployment.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

### Development Guidelines
- Follow the existing code style and architecture patterns
- Write meaningful commit messages
- Add tests for new features
- Update documentation as needed
- Ensure all builds pass before submitting PR

## 🎬 Demo Videos

Demo videos will be uploaded soon to showcase the app's features and functionality.

## 👥 Contributors

### Mobile Development
- [Mohamed Emad](https://github.com/Mohamed02Emad) -
- [Salma Fawzy](https://github.com/SalmaElarabyFawzy) -

### Backend Development
- [Ahmed Ghoneim](https://github.com/ahmedghoneim510) -
- [Norhan Ihab](https://github.com/MiraculouN) -

### Frontend Development
- [Bashar Elmetwali](https://github.com/BasharElmetwaliahmed) -
- [Norhan Magdy](https://github.com/BasharElmetwaliahmed) -
- Norhan Magdy -

### AI Development
- [Salma Hafez](https://github.com/SalmaAhmedHafez) -
- [Aya Hazem](https://github.com/ayahazem6103) -

### Design
- [Manar Elsadaty](https://www.behance.net/manar_elsadaty) - 

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- All contributors who helped build this project
- The design and UX team for the beautiful interface
- Beta testers for their valuable feedback

---

**Made with ❤️ using Flutter**
