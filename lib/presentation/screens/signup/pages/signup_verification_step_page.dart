import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/screens/signup/components/verification_non_libyan_page.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/widgets/page_content_padding.dart';

class SignUpVerificationStepPage extends StatelessWidget {
  const SignUpVerificationStepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
      height:
          MediaQuery.of(context).size.height - kToolbarHeight - AppSizes.s30,
      child: const PageContentPadding(
        child: VerificationNonLibyanPage(),
      ),
    ));
  }
}
