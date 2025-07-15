# Development Commands

## Flutter Version
Use Flutter 3.29.2 with FVM

## Code Generation
For generating code (models, dependency injection, etc.):
```shell
fvm flutter packages pub run build_runner clean
fvm flutter packages pub run build_runner build
```

## App Assets
Generate launch icon:
```shell
fvm flutter pub run flutter_launcher_icons
```

Generate splash screen:
```shell
fvm flutter pub run flutter_native_splash:create
```

## Android Configuration
Get SHA1 fingerprint:
```shell
cd android
./gradlew signingReport
```

## App Configuration
Change package name:
```shell
fvm flutter pub run change_app_package_name:main com.decorizer.mobile
```

Change app name:
```shell
fvm flutter pub run rename_app:main all="Decorizer"
```

## Localization
Generate localization keys file:
```shell
fvm flutter pub run easy_localization:generate -S "assets/translations" -O "lib/common/resources/gen" -o "locale_keys.g.dart" -f keys
```

## Build Commands
Build APK:
```shell
fvm flutter build apk --release
```

Build App Bundle (for Play Store):
```shell
fvm flutter build appbundle --release
```

Build iOS:
```shell
fvm flutter build ios --release
```

## Development
Run in debug mode:
```shell
fvm flutter run
```

Run in release mode:
```shell
fvm flutter run --release
```

Clean project:
```shell
fvm flutter clean
fvm flutter pub get
```
