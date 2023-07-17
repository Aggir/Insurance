import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/language_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.test.tr()),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                if (context.locale.languageCode ==
                    LanguageType.english.getLocale().languageCode) {
                  context.setLocale(LanguageType.arabic.getLocale());
                } else {
                  context.setLocale(LanguageType.english.getLocale());
                }
              },
              icon: const Icon(Icons.translate))
        ],
      ),
    );
  }
}
