import 'dart:async';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
String ONBOARD_KEY = "GD2G82CG9G82VDFGVD22DVG";
// ignore: non_constant_identifier_names
String TOKEN_KEY = "SDFK3F8465ESOPKOK56N4GLK";

class AppService with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  String _token = Constants.empty;
  bool _onboarding = false;

  AppService(this.sharedPreferences);

  String get token => _token;
  bool get onboarding => _onboarding;

  set token(String value) {
    sharedPreferences.setString(TOKEN_KEY, value);
    _token = value;
    notifyListeners();
  }

  set onboarding(bool value) {
    sharedPreferences.setBool(ONBOARD_KEY, value);
    _onboarding = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    _onboarding = sharedPreferences.getBool(ONBOARD_KEY) ?? false;
    _token = sharedPreferences.getString(TOKEN_KEY) ?? Constants.empty;
    notifyListeners();
  }
}
