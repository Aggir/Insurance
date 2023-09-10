import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/domain/data_classes/insurance_document_parameters.dart';
import 'package:insurance_app/domain/data_classes/my_isurances_page_parameters.dart';
import 'package:insurance_app/domain/data_classes/payment_step_parameters.dart';
import 'package:insurance_app/presentation/blocs/company_branches/company_branches_cubit.dart';
import 'package:insurance_app/presentation/blocs/compare_companies/compare_companies_cubit.dart';
import 'package:insurance_app/presentation/blocs/my_alarms/my_alarms_cubit.dart';
import 'package:insurance_app/presentation/blocs/my_insurances/my_insurances_cubit.dart';
import 'package:insurance_app/presentation/blocs/notifications/notifications_cubit.dart';
import 'package:insurance_app/presentation/blocs/user/user_cubit.dart';
import 'package:insurance_app/presentation/screens/index.dart';

import '../../presentation/blocs/add_my_vehicle/add_my_vehicle_cubit.dart';
import '../../presentation/blocs/change_password/change_password_cubit.dart';
import '../../presentation/blocs/forgot_password/forgot_password_cubit.dart';
import '../../presentation/blocs/issue_insurance/issue_insurance_cubit.dart';
import '../../presentation/blocs/login/login_cubit.dart';
import '../../presentation/blocs/my_vehicles/my_vehicles_cubit.dart';
import '../../presentation/blocs/payment/payment_cubit.dart';
import '../../presentation/blocs/profile/profile_cubit.dart';
import '../../presentation/blocs/add_reminder/add_reminder_cubit.dart';
import '../../presentation/blocs/sign_up/sign_up_cubit.dart';

class AppRoutes {
  static final onboarding = GoRoute(
    path: AppScreen.onboarding.toPath,
    name: AppScreen.onboarding.toName,
    builder: (BuildContext context, GoRouterState state) {
      return const OnboardingScreen();
    },
  );

  static final termsAndConditions = GoRoute(
    path: AppScreen.termsAndConditions.toPath,
    name: AppScreen.termsAndConditions.toName,
    builder: (BuildContext context, GoRouterState state) {
      return TermsAndConditionsScreen(state.extra != null);
    },
  );

  static final loading = GoRoute(
    path: AppScreen.loading.toPath,
    name: AppScreen.loading.toName,
    builder: (BuildContext context, GoRouterState state) {
      return const LoadingScreen();
    },
  );

  static final login = GoRoute(
    path: AppScreen.login.toPath,
    name: AppScreen.login.toName,
    redirect: _nonAuthenticatedRoute,
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (context) => LoginCubit(),
        child: const LoginScreen(),
      );
    },
  );

  static final noConnection = GoRoute(
    path: AppScreen.noConnection.toPath,
    name: AppScreen.noConnection.toName,
    builder: (BuildContext context, GoRouterState state) {
      return const NoConnectionScreen();
    },
  );

  static final myPayments = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.myPayments.toPath,
    name: AppScreen.myPayments.toName,
    builder: (BuildContext context, GoRouterState state) {
      return const MyPaymentsScreen();
    },
  );

  static final profile = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.profile.toPath,
    name: AppScreen.profile.toName,
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (context) => ProfileCubit(),
        child: const ProfileScreen(),
      );
    },
  );

  static final settings = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.settings.toPath,
    name: AppScreen.settings.toName,
    builder: (BuildContext context, GoRouterState state) {
      return const SettingsScreen();
    },
    routes: [_changePassword],
  );

  static final insuranceDocument = GoRoute(
    redirect: _authenticatedRoute,
    path: '${AppScreen.insuranceDocument.toPath}:reference_number',
    name: AppScreen.insuranceDocument.toName,
    builder: (BuildContext context, GoRouterState state) {
      return InsuranceDocument(state.extra as InsuranceDocumentParameters);
    },
  );

  static final notifications = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.notifications.toPath,
    name: AppScreen.notifications.toName,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return const CupertinoPage(child: NotificationsScreen());
    },
  );

  static final companies = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.companies.toPath,
    name: AppScreen.companies.toName,
    builder: (BuildContext context, GoRouterState state) {
      return const InsuranceCompaniesScreen();
    },
    routes: [_companyDetails],
  );

  static final vehiclesInsurance = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.vehiclesInsurance.toPath,
    name: AppScreen.vehiclesInsurance.toName,
    builder: (context, state) {
      initCompareCompaniesCubit();
      return BlocProvider(
        create: (context) => instance<CompareCompaniesCubit>(),
        child: const VehiclesInsuranceScreen(),
      );
    },
  );

  static final comparePrices = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.comparePrices.toPath,
    name: AppScreen.comparePrices.toName,
    builder: (context, state) => BlocProvider.value(
      value: instance<CompareCompaniesCubit>(),
      child: const ComparePricesScreen(),
    ),
  );

  static final myHiddenVehicles = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.myHiddenVehicles.toPath,
    name: AppScreen.myHiddenVehicles.toName,
    pageBuilder: (context, state) =>
        const CupertinoPage(child: MyHiddenVehiclesScreen()),
  );

  static final myAlarms = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.myAlarms.toPath,
    name: AppScreen.myAlarms.toName,
    pageBuilder: (context, state) => CupertinoPage(
        child: BlocProvider(
      create: (context) => MyAlarmsCubit()..init(),
      child: const MyAlarmsScreen(),
    )),
  );
  // -------------------------------------------------------------------
  // sub routes

  static final _changePassword = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.changePassword.toSubPath,
    name: AppScreen.changePassword.toName,
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (context) => ChangePasswordCubit(),
        child: const ChangePasswordScreen(),
      );
    },
  );

  static final _companyDetails = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.companyDetails.toSubPath,
    name: AppScreen.companyDetails.toName,
    builder: (BuildContext context, GoRouterState state) {
      return const CompanyDetailsScreen();
    },
    routes: [_companyBranches],
  );

  static final _companyBranches = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.companyBranches.toSubPath,
    name: AppScreen.companyBranches.toName,
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (context) => CompanyBranchesCubit(),
        child: CompanyBranchesScreen(state.pathParameters['company_id'] ?? '0'),
      );
    },
  );

  //-----------------------------------------------------------------------
  // statefulShellRoutes

  static final signUp = StatefulShellRoute.indexedStack(
    builder: (context, state, child) {
      return BlocProvider(
        create: (context) => SignUpCubit(),
        child: SignUpStepsScreen(child, state.uri.toString()),
      );
    },
    branches: _signupBranches,
  );

  static final addMyVehicle = StatefulShellRoute.indexedStack(
    builder: (context, state, child) {
      return BlocProvider(
        create: (context) => AddMyVehicleCubit(),
        child: AddMyVehicleStepsScreen(child, state.uri.toString()),
      );
    },
    branches: _addMyVehicleBranches,
  );

  static final forgotPassword = StatefulShellRoute.indexedStack(
    builder: (context, state, child) {
      return BlocProvider(
        create: (context) => ForgotPasswordCubit(),
        child: ForgotPasswordStepsScreen(child, state.uri.toString()),
      );
    },
    branches: _forgotPasswordBranches,
  );

  static final reminder = StatefulShellRoute.indexedStack(
    builder: (context, state, child) {
      return BlocProvider(
        create: (context) => AddReminderCubit(),
        child: ReminderStepsScreen(child, state.uri.toString()),
      );
    },
    branches: _reminderBranches,
  );

  static final home = StatefulShellRoute.indexedStack(
    builder: (context, state, child) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MyVehiclesCubit()..init()),
          BlocProvider(create: (context) => MyInsurancesCubit()..init()),
          BlocProvider(
              create: (context) =>
                  NotificationsCubit()..startUnseenNotificationsTimer()),
        ],
        child: Builder(builder: (context) {
          return BlocBuilder<MyVehiclesCubit, MyVehiclesState>(
            builder: (context, cubitState) {
              return HomeScreen(child, state.uri.toString());
            },
          );
        }),
      );
    },
    branches: _homeBranches,
  );

  static final issueInsurance = StatefulShellRoute.indexedStack(
    builder: (context, state, child) {
      return BlocProvider(
        create: (context) => IssueInsuranceCubit()..fetchInsuranceFormData(),
        child: IssueInsuranceStepsScreen(
            child, state.uri.toString(), state.extra as String?),
      );
    },
    branches: _issueInsuranceBranches,
  );

  static final payment = StatefulShellRoute.indexedStack(
    builder: (context, state, child) {
      return BlocProvider(
        create: (context) => PaymentCubit(),
        child: PaymentStepsScreen(child, state.uri.toString()),
      );
    },
    branches: _paymentBranches,
  );

  //-------------------------------------------------------------------
  // --------------------------- BRANCHES -----------------------------

  // ---------- Signup ---------
  static final _signup = GoRoute(
    redirect: _nonAuthenticatedRoute,
    path: AppScreen.signup.toPath,
    name: AppScreen.signup.toName,
    builder: (context, state) => const SignUpUserInfoStepPage(),
  );

  static final _signupPasswordStep = GoRoute(
    redirect: _nonAuthenticatedRoute,
    path: AppScreen.signupPasswordStep.toPath,
    name: AppScreen.signupPasswordStep.toName,
    builder: (context, state) => const SignUpPasswordStepPage(),
  );

  static final _signupSelectProofTypeStep = GoRoute(
    redirect: _nonAuthenticatedRoute,
    path: AppScreen.signupSelectProofTypeStep.toPath,
    name: AppScreen.signupSelectProofTypeStep.toName,
    pageBuilder: (context, state) => const MaterialPage(
      child: SignUpSelectProofTypeStep(),
    ),
  );

  static final _signupProofInfoStep = GoRoute(
    redirect: _nonAuthenticatedRoute,
    path: AppScreen.signupProofInfoStep.toPath,
    name: AppScreen.signupProofInfoStep.toName,
    pageBuilder: (context, state) => const MaterialPage(
      child: SignUpProofInfoStepPage(),
    ),
  );

  static final _signupNationalInfoStep = GoRoute(
    redirect: _nonAuthenticatedRoute,
    path: AppScreen.signupNationalInfoStep.toPath,
    name: AppScreen.signupNationalInfoStep.toName,
    pageBuilder: (context, state) => const MaterialPage(
      child: SignUpNationalInfoPage(),
    ),
  );

  static final _signupOtpStep = GoRoute(
    redirect: _nonAuthenticatedRoute,
    path: AppScreen.signupOtpStep.toPath,
    name: AppScreen.signupOtpStep.toName,
    builder: (context, state) => const SignUpOtpStepPage(),
  );

  static final _signupBranches = [
    StatefulShellBranch(routes: [_signup]),
    StatefulShellBranch(routes: [_signupPasswordStep]),
    StatefulShellBranch(routes: [
      _signupSelectProofTypeStep,
      _signupProofInfoStep,
      _signupNationalInfoStep,
    ]),
    StatefulShellBranch(routes: [_signupOtpStep]),
  ];

  static int get signupBranchesCount => _signupBranches.length;

  // ------- AddMyVehicle Branches ----------

  static final _addMyVehicle = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.addMyVehicle.toPath,
    name: AppScreen.addMyVehicle.toName,
    builder: (context, state) => const AddMyVehicleUserInfoStepPage(),
  );

  static final _addMyVehicleDetailsStepOne = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.addMyVehicleDetailsStepOne.toPath,
    name: AppScreen.addMyVehicleDetailsStepOne.toName,
    pageBuilder: (context, state) => const MaterialPage(
      child: AddMyVehicleDetailsStepOnePage(),
    ),
  );

  static final _addMyVehicleDetailsStepTwo = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.addMyVehicleDetailsStepTwo.toPath,
    name: AppScreen.addMyVehicleDetailsStepTwo.toName,
    pageBuilder: (context, state) => const MaterialPage(
      child: AddMyVehicleDetailsStepTwoPage(),
    ),
  );

  static final _addMyVehiclePictureStep = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.addMyVehiclePictureStep.toPath,
    name: AppScreen.addMyVehiclePictureStep.toName,
    builder: (context, state) => const AddMyVehiclePictureStepPage(),
  );

  static final _addMyVehicleBranches = [
    StatefulShellBranch(routes: [_addMyVehicle]),
    StatefulShellBranch(routes: [
      _addMyVehicleDetailsStepOne,
      _addMyVehicleDetailsStepTwo,
    ]),
    StatefulShellBranch(routes: [_addMyVehiclePictureStep]),
  ];

  static int get addMyVehicleBranchesCount => _addMyVehicleBranches.length;

  // ---------- ForgotPassword Branches ----------

  static final _forgotPassword = GoRoute(
    redirect: _nonAuthenticatedRoute,
    path: AppScreen.forgotPassword.toPath,
    name: AppScreen.forgotPassword.toName,
    builder: (context, state) => const ForgotPasswordSendOtpPage(),
  );

  static final _forgotPasswordVerifyOtpStep = GoRoute(
    redirect: _nonAuthenticatedRoute,
    path: AppScreen.forgotPasswordVerifyOtpStep.toPath,
    name: AppScreen.forgotPasswordVerifyOtpStep.toName,
    builder: (context, state) => const ForgotPasswordVerifyOtpPage(),
  );

  static final _forgotPasswordResetStep = GoRoute(
    redirect: _nonAuthenticatedRoute,
    path: AppScreen.forgotPasswordResetStep.toPath,
    name: AppScreen.forgotPasswordResetStep.toName,
    builder: (context, state) => const ForgotPasswordRestPasswordPage(),
  );

  static final _forgotPasswordBranches = [
    StatefulShellBranch(routes: [_forgotPassword]),
    StatefulShellBranch(routes: [_forgotPasswordVerifyOtpStep]),
    StatefulShellBranch(routes: [_forgotPasswordResetStep]),
  ];

  static int get forgotPasswordBranchesCount => _forgotPasswordBranches.length;

  // ------- Home branches ----------

  static final _home = GoRoute(
    path: AppScreen.home.toPath,
    name: AppScreen.home.toName,
    redirect: _authenticatedRoute,
    builder: (context, state) => HomePage(dialog: state.extra as Widget?),
  );

  static final _myVehicles = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.myVehicles.toPath,
    name: AppScreen.myVehicles.toName,
    builder: (context, state) => MyVehiclesPage(state.extra as bool? ?? false),
  );

  static final _myInsurances = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.myInsurances.toPath,
    name: AppScreen.myInsurances.toName,
    builder: (context, state) {
      final MyInsurancesPageParameters? extraParams =
          state.extra is MyInsurancesPageParameters
              ? state.extra as MyInsurancesPageParameters
              : null;

      return MyInsurancesPage(
        pageIndex: extraParams?.pageIndex,
        isPaymentModelShown: extraParams?.isPaymentModalShown,
        selectedInsuranceId: extraParams?.selectedInsuranceId,
      );
    },
  );

  static final _more = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.more.toPath,
    name: AppScreen.more.toName,
    builder: (context, state) => const MorePage(),
  );

  static final _homeBranches = [
    StatefulShellBranch(routes: [_home]),
    StatefulShellBranch(routes: [_myVehicles]),
    StatefulShellBranch(routes: [_myInsurances]),
    StatefulShellBranch(routes: [_more]),
  ];

  static int get homeBranchesCount => _homeBranches.length;

  // ----------- Payment Branches ----------

  static final _payment = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.payment.toPath,
    name: AppScreen.payment.toName,
    builder: (context, state) =>
        PaymentSendOtpPage(state.extra as PaymentStepParameters?),
  );

  static final _paymentVerifyOtpStep = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.paymentVerifyOtpStep.toPath,
    name: AppScreen.paymentVerifyOtpStep.toName,
    builder: (context, state) => const PaymentVerifyOtpPage(),
  );

  static final _paymentBranches = [
    StatefulShellBranch(routes: [_payment]),
    StatefulShellBranch(routes: [_paymentVerifyOtpStep]),
  ];

  static int get paymentBranchesCount => _paymentBranches.length;

  // ----------- IssueInsurance Branches -----------

  static final _issueInsurance = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.issueInsurance.toPath,
    name: AppScreen.issueInsurance.toName,
    builder: (context, state) => const IssueFormStepPage(),
  );

  static final _issueInsuranceInstallmentDetails = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.issueInstallmentDetails.toPath,
    name: AppScreen.issueInstallmentDetails.toName,
    builder: (context, state) => const InstallmentDetailsStepPage(),
  );

  static final _issueInsuranceBranches = [
    StatefulShellBranch(routes: [_issueInsurance]),
    StatefulShellBranch(routes: [_issueInsuranceInstallmentDetails]),
  ];

  static int get issueInsuranceBranchesCount => _paymentBranches.length;

  // ----------- Reminder Branches ------------

  static final _reminder = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.reminder.toPath,
    name: AppScreen.reminder.toName,
    builder: (context, state) => const ReminderInfoFormStepPage(),
  );

  static final _reminderInsuranceInfoStep = GoRoute(
    redirect: _authenticatedRoute,
    path: AppScreen.reminderInsuranceInfoStep.toPath,
    name: AppScreen.reminderInsuranceInfoStep.toName,
    builder: (context, state) => const ReminderInsuranceInfoStepPage(),
  );

  static final _reminderBranches = [
    StatefulShellBranch(routes: [_reminder]),
    StatefulShellBranch(routes: [_reminderInsuranceInfoStep]),
  ];

  static int get reminderBranchesCount => _reminderBranches.length;

  // ------------------------------------------------------------------------
  // ------------------------------- Redirect -------------------------------

  static FutureOr<String?> _authenticatedRoute(
      BuildContext context, GoRouterState state) {
    final cubit = BlocProvider.of<UserCubit>(context);
    if (cubit.state.user == null) {
      return state.namedLocation(AppScreen.login.toName);
    } else {
      return null;
    }
  }

  static FutureOr<String?> _nonAuthenticatedRoute(
      BuildContext context, GoRouterState state) {
    final cubit = BlocProvider.of<UserCubit>(context);
    if (cubit.state.user != null) {
      return state.namedLocation(AppScreen.home.toName);
    } else {
      return null;
    }
  }
}
