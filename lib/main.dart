import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'common/app/app.dart';
import 'common/app/init_services.dart';
import 'common/di/injection_container.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initServices();
  await configureDependencies();
  await initFCMServices();
  Future.delayed(Duration(milliseconds: 700)).then((_) {
    FlutterNativeSplash.remove();
  });
  final deviceLocale = WidgetsBinding.instance.window.locale;
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: const Locale('en'),
      startLocale: deviceLocale,
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: const App(),
    ),
  );
}
