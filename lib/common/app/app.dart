import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/theme/custom_theme_app.dart';
import 'package:decorizer/shared_features/chat/presentation/cubits/unread_message_count/unread_message_count_cubit.dart';
import 'package:decorizer/shared_features/notifications/domain/usecases/notifications_usecase.dart';
import 'package:decorizer/shared_features/notifications/presentation/cubits/unread_notifications_count/unread_notifications_count_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import '../../shared_features/setup_screens/presentation/pages/splash_screen.dart';
import '../constant/size_config.dart';
import '../data/preference/app_preferences.dart';
import '../data/preference/item/preference_item.dart';
import '../di/injection_container.dart';
import '../theme/custom_theme.dart';

BuildContext? appContext;

class App extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const defaultTheme = CustomTheme.light;
  static bool isForeground = true;

  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> with Nav, WidgetsBindingObserver {
  @override
  GlobalKey<NavigatorState> get navigatorKey => App.navigatorKey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future<void>.microtask(() {
      final String local =
          EasyLocalization.of(context)!.currentLocale!.languageCode;
      PreferenceItem<String>(AppPreferences.language, local).set(local);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<LoginInfoCubit>(
                create: (context) => sl<LoginInfoCubit>(),
              ),
              BlocProvider<UnreadNotificationsCountCubit>(
                create: (context) => sl<UnreadNotificationsCountCubit>(),
              ),
              BlocProvider<UnreadMessageCountCubit>(
                create: (context) => sl<UnreadMessageCountCubit>(),
              ),
            ],
            child: CustomThemeApp(
              child: Builder(builder: (context) {
                SizeConfig().init(context);
                appContext ??= context;
                return MaterialApp(
                    navigatorKey: App.navigatorKey,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    title: '',
                    theme: context.themeType.themeData,
                    debugShowCheckedModeBanner: false,
                    home: const SplashScreen());
              }),
            ),
          );
        });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        App.isForeground = true;
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        App.isForeground = false;
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
