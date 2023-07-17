import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import './app/language_manager.dart';
import 'presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: appLocales,
      path: assetsPathLocalization,
      fallbackLocale: defaultLocale,
      saveLocale: true,
      child: MyApp(),
    ),
  );
}
