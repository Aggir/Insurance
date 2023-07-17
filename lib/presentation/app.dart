import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../app/constants.dart';
import 'app_router.dart';
import 'theme/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal({Key? key}) : super(key: key);

  static const MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: appThemeData(),
      initialRoute: Routes.onboardingRoute,
      onGenerateRoute: RouteGenerator().generateRoute,
    );
  }
}
