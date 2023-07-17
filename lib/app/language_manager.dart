import 'package:flutter/material.dart';

enum LanguageType {
  arabic,
  english,
}

const Locale _arabicLocale = Locale('ar');
const Locale _englishLocale = Locale('en');

const List<Locale> appLocales = [_arabicLocale, _englishLocale];
Locale get defaultLocale => _arabicLocale;
const String assetsPathLocalization = 'assets/localization';

extension LanguageTypeExtension on LanguageType {
  Locale getLocale() {
    switch (this) {
      case LanguageType.arabic:
        return _arabicLocale;
      case LanguageType.english:
        return _englishLocale;
    }
  }
}
