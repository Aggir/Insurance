import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insurance_app/presentation/screens/signup/pages/signup_password_step_page.dart';
import 'package:insurance_app/presentation/widgets/form_scaffold.dart';

import '../../theme/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import 'components/custom_indicator.dart';
import 'pages/signup_verification_step_page.dart';

class SignUpStepsPage extends StatefulWidget {
  const SignUpStepsPage({super.key});

  @override
  State<SignUpStepsPage> createState() => _SignUpStepsPageState();
}

class _SignUpStepsPageState extends State<SignUpStepsPage> {
  final PageController _controller = PageController(initialPage: 0);
  double _pageIndex = 0;
  late List<Widget> _pages;

  void _nextFunction() {
    _controller.animateToPage(
      (_pageIndex + 1).round(),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  void initState() {
    _pages = [
      SignUpPasswordStepPage(_controller),
      const SignUpVerificationStepPage(),
    ];
    _controller.addListener(() {
      setState(() {
        _pageIndex = _controller.page ?? 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        leading: CustomBackButton(
            onTap: _pageIndex > 0
                ? () {
                    _controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  }
                : null),
        actions: [
          CustomIndicator(
            currentPage: _pageIndex + 1,
            pageCount: _pages.length + 1,
          ),
        ],
      ),
      body: PageView.builder(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _pages.length,
        itemBuilder: (context, index) => _pages[index],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
