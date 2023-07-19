import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/screens/signup/components/signup_page_content.dart';
import 'package:insurance_app/presentation/widgets/form_scaffold.dart';

import '../../../app/assets_manager.dart';
import '../../theme/app_colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FormScaffold(
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
                  image: AssetImage(ImageAssets.signupBackground),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SignUpPageContent(),
          ),
        ],
      ),
    );
  }
}
