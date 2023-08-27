import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/presentation/screens/login/components/login_page_content.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';

import '../../blocs/login/login_cubit.dart';
import '../../blocs/user/user_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    if (BlocProvider.of<UserCubit>(context).state.checkTokenStatus.isInitial) {
      BlocProvider.of<UserCubit>(context).isLoggedIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => BlocProvider.of<LoginCubit>(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryLightest,
                  image: const DecorationImage(
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                    image: AssetImage(ImageAssets.loginBackground),
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: LoginPageContent(),
            ),
          ],
        ),
      ),
    );
  }
}
