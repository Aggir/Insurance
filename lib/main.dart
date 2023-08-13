import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import './app/language_manager.dart';
import 'app/helpers/app_service.dart';
import 'presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  await instance<AppService>().onAppStart();
  runApp(
    EasyLocalization(
      supportedLocales: appLocales,
      path: assetsPathLocalization,
      fallbackLocale: defaultLocale,
      startLocale: defaultLocale,
      // saveLocale: true,
      child: MyApp(),
    ),
  );
}
