import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/app/router/app_routes.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/blocs/internet/internet_bloc.dart';
import 'package:insurance_app/presentation/blocs/user/user_cubit.dart';
import 'package:insurance_app/presentation/screens/index.dart';

import '../../presentation/blocs/companies/companies_cubit.dart';
import '../di/dependency_injection.dart';
import '../helpers/app_service.dart';

class NavigatorKeys {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey(debugLabel: 'root');
}

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    navigatorKey: NavigatorKeys.rootNavigatorKey,
    initialLocation: AppScreen.home.toPath,
    redirect: _redirectToOnboarding,
    routes: <RouteBase>[
      ShellRoute(
        routes: [
          AppRoutes.onboarding,
          AppRoutes.termsAndConditions,
          AppRoutes.loading,
          AppRoutes.login,
          AppRoutes.noConnection,
          AppRoutes.myPayments,
          AppRoutes.profile,
          AppRoutes.settings,
          AppRoutes.insuranceDocument,
          AppRoutes.notifications,
          AppRoutes.companies,
          AppRoutes.carsInsurance,
          AppRoutes.comparePrices,
          AppRoutes.signUp,
          AppRoutes.addMyVehicle,
          AppRoutes.forgotPassword,
          AppRoutes.reminder,
          AppRoutes.home,
          AppRoutes.issueInsurance,
          AppRoutes.payment,
        ],
        builder: (context, state, child) => BlocProvider(
          create: (context) => CompaniesCubit(),
          child: Builder(builder: (context) {
            return BlocConsumer<InternetBloc, InternetState>(
              listener: (context, state) {
                if (state is DisconnectedState) {
                  context.go(AppScreen.noConnection.toPath);
                } else if (state is ConnectedState) {
                  context.go(AppScreen.login.toPath);
                }
              },
              builder: (context, state) {
                if (state is DisconnectedState) {
                  return const NoConnectionScreen();
                } else if (state is ConnectedState) {
                  return BlocListener<UserCubit, UserState>(
                    listenWhen: (previous, current) =>
                        previous.authStatus != current.authStatus,
                    listener: (context, state) {
                      if (state.checkTokenStatus.isFailure) {
                        context.go(AppScreen.login.toPath);
                      } else if (state.authStatus.isLoading &&
                          state.checkTokenStatus.isLoading) {
                        context.go(AppScreen.loading.toPath);
                      } else if (state.user == null &&
                          (state.authStatus.isInitial ||
                              state.authStatus.isSuccess)) {
                        context.go(AppScreen.login.toPath);
                      } else if (state.user != null &&
                          (state.authStatus.isSuccess)) {
                        context.go(AppScreen.home.toPath);
                      }
                    },
                    child: child,
                  );
                } else {
                  return const LoadingScreen();
                }
              },
            );
          }),
        ),
      ),
    ],
  );

  static FutureOr<String?> _redirectToOnboarding(
      BuildContext context, GoRouterState state) {
    final AppService appService = instance<AppService>();
    final userCubit = BlocProvider.of<UserCubit>(context);

    if (userCubit.state.checkTokenStatus.isLoading) {
      return state.namedLocation(AppScreen.loading.toName);
    } else if (!appService.onboarding) {
      return state.namedLocation(AppScreen.onboarding.toName);
    } else {
      return null;
    }
  }
}
