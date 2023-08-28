import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/app/language_manager.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import '../app/constants.dart';
import '../app/di/dependency_injection.dart';
import '../app/router/app_router.dart';
import 'blocs/internet/internet_bloc.dart';
import 'blocs/user/user_cubit.dart';
import 'theme/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal({Key? key}) : super(key: key);

  static const MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    Intl.defaultLocale = LanguageType.english.getLocale().countryCode;
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => instance<UserCubit>()..isLoggedIn(),
          ),
          BlocProvider(create: (context) => instance<InternetBloc>()),
        ],
        child: MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: Constants.appName,
          debugShowCheckedModeBanner: false,
          theme: appThemeData(),
          routerConfig: AppRouter.appRouter,
        ),
      ),
    );
  }
}
