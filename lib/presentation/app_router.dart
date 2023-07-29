import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/domain/entities/payment_method.dart';
import 'package:insurance_app/presentation/blocs/change_password/change_password_cubit.dart';
import 'package:insurance_app/presentation/blocs/forgot_password/forgot_password_cubit.dart';
import 'package:insurance_app/presentation/blocs/issue_insurance/issue_insurance_cubit.dart';
import 'package:insurance_app/presentation/blocs/payment/payment_cubit.dart';
import 'package:insurance_app/presentation/blocs/profile/profile_cubit.dart';
import 'package:insurance_app/presentation/screens/cars_insurance/cars_insurance_screen.dart';
import 'package:insurance_app/presentation/screens/change_password/change_password_screen.dart';
import 'package:insurance_app/presentation/screens/forgot_password/index.dart';
import 'package:insurance_app/presentation/screens/home/index.dart';
import 'package:insurance_app/presentation/screens/insurance_document/insurance_document_screen.dart';
import 'package:insurance_app/presentation/screens/insurance_payment/pages/send_otp_step_page.dart';
import 'package:insurance_app/presentation/screens/insurance_payment/pages/verify_otp_step_page.dart';
import 'package:insurance_app/presentation/screens/insurance_payment/payment_steps_screen.dart';
import 'package:insurance_app/presentation/screens/issue_insurance/index.dart';
import 'package:insurance_app/presentation/screens/loading/loading_screen.dart';
import 'package:insurance_app/presentation/screens/login/login_screen.dart';
import 'package:insurance_app/presentation/screens/my_payments/my_payments_screen.dart';
import 'package:insurance_app/presentation/screens/no_connection/no_connection_screen.dart';
import 'package:insurance_app/presentation/screens/notifications/notifications_screen.dart';
import 'package:insurance_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:insurance_app/presentation/screens/profile/profile_screen.dart';
import 'package:insurance_app/presentation/screens/settings/settings_screen.dart';
import 'package:insurance_app/presentation/screens/signup/index.dart';
import 'package:insurance_app/presentation/screens/terms_and_conditions/terms_and_conditions_screen.dart';

import 'blocs/signup/signup_cubit.dart';

class NavigatorKeys {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey(debugLabel: 'root');
}

class Routes {
  static const String homeRoute = "/";
  static const String myVehiclesRoute = "/my-vehicles";
  static const String myInsurancesRoute = "/my-insurances";
  static const String insuranceDocumentRoute = "/insurance-document";
  static const String moreRoute = "/more";

  static const String onboardingRoute = "/onboarding";

  static const String termsAndConditionsRoute = "/terms-and-conditions";

  static const String loginRoute = "/login";

  static const String signupRoute = '/signup-user-info-step';
  static const String signupPasswordStepRoute = "/signup-password-step";
  static const String signupSelectVerificationMethodStepRoute =
      "/signup-select-verification-method-step";
  static const String signupVerificationStepRoute = "/signup-verification-step";
  static const String signupNationalIdNumberStepRoute =
      "/signup-national-id_number-step";

  static const String forgotPasswordRoute = '/forgot-password-send-otp';
  static const String forgotPasswordVerifyOtpStepRoute =
      '/forgot-password-verify-otp';
  static const String forgotPasswordResetPasswordStepRoute =
      '/forgot-password-reset-password';

  static const String loadingRoute = '/loading';
  static const String noConnectionRoute = "/no-connection";

  static const String myPaymentsRoute = "/my-payments";

  static const String settingsRoute = "/settings";
  static const String changePasswordRoute = "change-password";
  static const String settingsChangePasswordRoute =
      "$settingsRoute/$changePasswordRoute";

  static const String profileRoute = '/profile';

  static const String paymentRoute = '/payment-send-otp';
  static const String paymentVerifyOtpStepRoute = '/payment-verify-otp';

  static const String notificationsRoute = '/notifications';

  static const String carsInsuranceRoute = '/cars-insurance';

  static const String issueInsuranceRoute = '/issue-insurance';
  static const String issueInstallmentDetailsRoute =
      '/issue-installment-details';
}

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    navigatorKey: NavigatorKeys.rootNavigatorKey,
    initialLocation: Routes.homeRoute,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.onboardingRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: Routes.termsAndConditionsRoute,
        builder: (BuildContext context, GoRouterState state) {
          return TermsAndConditionsScreen(state.extra != null);
        },
      ),
      GoRoute(
        path: Routes.loadingRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const LoadingScreen();
        },
      ),
      GoRoute(
        path: Routes.loginRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: Routes.noConnectionRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const NoConnectionScreen();
        },
      ),
      GoRoute(
        path: Routes.myPaymentsRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const MyPaymentsScreen();
        },
      ),
      GoRoute(
        path: Routes.profileRoute,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => ProfileCubit(),
            child: const ProfileScreen(),
          );
        },
      ),
      GoRoute(
          path: Routes.settingsRoute,
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsScreen();
          },
          routes: [
            GoRoute(
              path: Routes.changePasswordRoute,
              builder: (BuildContext context, GoRouterState state) {
                return BlocProvider(
                  create: (context) => ChangePasswordCubit(),
                  child: const ChangePasswordScreen(),
                );
              },
            ),
          ]),
      GoRoute(
        path: '${Routes.insuranceDocumentRoute}:reference_number',
        builder: (BuildContext context, GoRouterState state) {
          return InsuranceDocument(
              state.pathParameters['reference_number'] ?? '0');
        },
      ),
      GoRoute(
        path: Routes.notificationsRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const NotificationsScreen();
        },
      ),
      GoRoute(
        path: Routes.carsInsuranceRoute,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const CarsInsuranceScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).chain(
                CurveTween(curve: Curves.easeIn),
              ),
            ),
            child: child,
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => SignUpCubit(),
            child: SignUpStepsScreen(child, state.uri.toString()),
          );
        },
        branches: _signupBranches,
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => ForgotPasswordCubit(),
            child: ForgotPasswordStepsScreen(child, state.uri.toString()),
          );
        },
        branches: _forgotPasswordBranches,
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) {
          return HomeScreen(child, state.uri.toString());
        },
        branches: _homeBranches,
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => IssueInsuranceCubit(),
            child: IssueInsuranceStepsScreen(child, state.uri.toString()),
          );
        },
        branches: _issueInsuranceBranches,
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => PaymentCubit(),
            child: PaymentStepsScreen(child, state.uri.toString()),
          );
        },
        branches: _paymentBranches,
      ),
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
        // builder: (context, state) => const SignUpSelectVerificationMethodStep(),
        pageBuilder: (context, state) => const MaterialPage(
          child: SignUpSelectVerificationMethodStep(),
        ),
      ),
      GoRoute(
        path: Routes.signupVerificationStepRoute,
        pageBuilder: (context, state) => const MaterialPage(
          child: SignUpVerificationStepPage(),
        ),
      ),
      GoRoute(
        path: Routes.signupNationalIdNumberStepRoute,
        // builder: (context, state) => const SignUpNationalIdNumberPage(),
        pageBuilder: (context, state) => const MaterialPage(
          child: SignUpNationalIdNumberPage(),
        ),
      ),
    ]),
  ];

  static final List<StatefulShellBranch> _forgotPasswordBranches = [
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.forgotPasswordRoute,
        builder: (context, state) => const ForgotPasswordSendOtpPage(),
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.forgotPasswordVerifyOtpStepRoute,
        builder: (context, state) => const ForgotPasswordVerifyOtpPage(),
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.forgotPasswordResetPasswordStepRoute,
        builder: (context, state) => const ForgotPasswordRestPasswordPage(),
      ),
    ]),
  ];

  static final List<StatefulShellBranch> _homeBranches = [
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.homeRoute,
        builder: (context, state) =>
            HomePage(firstLogin: state.extra as bool? ?? false),
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.myVehiclesRoute,
        builder: (context, state) =>
            MyVehiclesPage(state.extra as bool? ?? false),
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.myInsurancesRoute,
        builder: (context, state) => MyInsurancesPage(state.extra ?? 0),
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.moreRoute,
        builder: (context, state) => const MorePage(),
      ),
    ]),
  ];

  static final List<StatefulShellBranch> _paymentBranches = [
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.paymentRoute,
        builder: (context, state) =>
            PaymentSendOtpPage(state.extra as PaymentMethod?),
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.paymentVerifyOtpStepRoute,
        builder: (context, state) => const PaymentVerifyOtpPage(),
      ),
    ]),
  ];

  static final List<StatefulShellBranch> _issueInsuranceBranches = [
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.issueInsuranceRoute,
        builder: (context, state) => const IssueFormStepPage(),
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: Routes.issueInstallmentDetailsRoute,
        builder: (context, state) => const InstallmentDetailsStepPage(),
      ),
    ]),
  ];

  static int get signupSteps => _signupBranches.length;
  static int get forgotPasswordSteps => _signupBranches.length;
  static int get homeBranchesCount => _homeBranches.length;
  static int get paymentSteps => _paymentBranches.length;
}
