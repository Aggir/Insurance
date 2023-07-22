import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/screens/login/login_screen.dart';
import 'package:insurance_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:insurance_app/presentation/screens/signup/pages/national_id_number_page.dart';
import 'package:insurance_app/presentation/screens/signup/pages/password_step_page.dart';
import 'package:insurance_app/presentation/screens/signup/pages/select_verification_method_page.dart';
import 'package:insurance_app/presentation/screens/signup/pages/user_info_step_page.dart';
import 'package:insurance_app/presentation/screens/signup/pages/verification_step_page.dart';
import 'package:insurance_app/presentation/screens/signup/signup_steps_screen.dart';

import 'blocs/signup/signup_cubit.dart';

class NavigatorKeys {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey(debugLabel: 'root');
  static GlobalKey<NavigatorState> signupShellNavigatorKey =
      GlobalKey(debugLabel: 'signup-shell');
}

class Routes {
  static const String homeRoute = "/";
  static const String onboardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String signupRoute = '/signup-user-info-step';
  static const String signupPasswordStepRoute = "/signup-password-step";
  static const String signupSelectVerificationMethodStepRoute =
      "/signup-select-verification-method-step";
  static const String signupVerificationStepRoute = "/signup-verification-step";
  static const String signupNationalIdNumberStepRoute =
      "/signup-national-id_number-step";
}

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    navigatorKey: NavigatorKeys.rootNavigatorKey,
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
      StatefulShellRoute.indexedStack(
          builder: (context, state, child) {
            return BlocProvider(
              create: (context) => SignUpCubit(),
              child: SignUpStepsPage(child, state.location),
            );
          },
          branches: _signupBranches),
    ],
  );

  static final List<StatefulShellBranch> _signupBranches = [
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.signupRoute,
        builder: (context, state) => const SignUpUserInfoStepPage(),
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.signupPasswordStepRoute,
        builder: (context, state) => const SignUpPasswordStepPage(),
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.signupSelectVerificationMethodStepRoute,
        builder: (context, state) => const SignUpSelectVerificationMethodStep(),
      ),
      GoRoute(
        path: Routes.signupVerificationStepRoute,
        builder: (context, state) => const SignUpVerificationStepPage(),
      ),
      GoRoute(
        path: Routes.signupNationalIdNumberStepRoute,
        builder: (context, state) => const SignUpNationalIdNumberPage(),
      ),
    ]),
  ];

  static int get signupSteps => _signupBranches.length;
}
