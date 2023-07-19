import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/screens/login/login_screen.dart';
import 'package:insurance_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:insurance_app/presentation/screens/signup/signup_steps_screen.dart';
import 'package:insurance_app/presentation/screens/signup/signup_screen.dart';

class Routes {
  static const String homeRoute = "/";
  static const String onboardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String signupRoute = "/signup";
  static const String signupStepsRoute =
      '$signupRoute/${SignupRoutes.stepsRoute}';
}

class SignupRoutes {
  static const String stepsRoute = "password";
}

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    initialLocation: Routes.signupRoute,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.onboardingRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: Routes.loginRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
          path: Routes.signupRoute,
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpScreen();
          },
          routes: [
            GoRoute(
              path: SignupRoutes.stepsRoute,
              builder: (BuildContext context, GoRouterState state) {
                return const SignUpStepsPage();
              },
            )
          ]),
    ],
  );
}
