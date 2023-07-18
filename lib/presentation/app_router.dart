import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/screens/onboarding/onboarding_screen.dart';

class Routes {
  static const String homeRoute = "/";
  static const String onboardingRoute = "/onboarding";
}

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    initialLocation: Routes.onboardingRoute,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.onboardingRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingScreen();
        },
      ),
    ],
  );
}
