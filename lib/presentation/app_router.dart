import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/screens/onboarding/onboarding_screen.dart';

import '../app/app_strings.dart';

class Routes {
  static const String homeRoute = "/";
  static const String onboardingRoute = "/onboarding";
}

class RouteGenerator {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingRoute:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound).tr(),
        ),
        body: Center(
          child: const Text(AppStrings.noRouteFound).tr(),
        ),
      ),
    );
  }
}
