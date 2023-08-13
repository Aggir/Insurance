import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/blocs/user/user_cubit.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listenWhen: (previous, current) =>
          previous.checkTokenStatus != current.checkTokenStatus,
      listener: (context, state) {
        if (state.checkTokenStatus.isFailure) {
          context.go(AppScreen.login.toPath);
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            GifAssets.loading,
            height: AppSizes.s150.r,
            width: AppSizes.s150.r,
          ),
        ),
      ),
    );
  }
}
