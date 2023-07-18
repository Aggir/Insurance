import 'package:flutter/material.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/screens/login/components/login_page_content.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.paleYellow,
                image: const DecorationImage(
                  alignment: Alignment.topCenter,
                  // fit: BoxFit.fill,
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
    );
  }
}
