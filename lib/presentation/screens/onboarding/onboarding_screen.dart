import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';

import '../../../app/assets_manager.dart';
import '../../theme/app_colors.dart';
import 'components/dot_indicator.dart';
import 'components/onboarding_page_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _pageIndex = 0;

  final List<Widget> _pages = [
    OnboardingPageContent(
      imgBackgroundColor: AppColors.paleYellow,
      imgPath: ImageAssets.onboardingOne,
      header: AppStrings.onboardingOneHeader,
      description: AppStrings.onboardingOneDescription,
    ),
    OnboardingPageContent(
      imgBackgroundColor: AppColors.paleYellow,
      imgPath: ImageAssets.onboardingTwo,
      header: AppStrings.onboardingTwoHeader,
      description: AppStrings.onboardingTwoDescription,
    ),
    OnboardingPageContent(
      imgBackgroundColor: AppColors.lightMintGreen,
      imgPath: ImageAssets.onboardingThree,
      header: AppStrings.onboardingThreeHeader,
      description: AppStrings.onboardingThreeDescription,
    ),
  ];

  void _skipFunction() {
    _controller.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _nextFunction() {
    _controller.animateToPage(
      _pageIndex + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _doneFunction() {
    //Todo: Navigate to another screen
  }

  bool get _isTheLastPage => _pageIndex == _pages.length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  children: _pages,
                  onPageChanged: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppValues.medium, 0, AppValues.medium, AppValues.large),
                child: Row(
                  children: [
                    ...List.generate(
                      _pages.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(AppValues.extraSmall),
                        child: DotIndicator(
                          isActive: _pageIndex == index,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: AppSizes.s62,
                      width: AppSizes.s62,
                      child: ElevatedButton(
                        onPressed:
                            _isTheLastPage ? _doneFunction : _nextFunction,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: _isTheLastPage
                              ? AppColors.green
                              : AppColors.primary,
                        ),
                        child: SvgPicture.asset(
                          _isTheLastPage
                              ? SvgAssets.checkMark
                              : SvgAssets.chevronLeft,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!_isTheLastPage)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppValues.small, horizontal: AppValues.medium),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _skipFunction,
                      child: Text(
                        AppStrings.skip.tr(),
                        style: textButtonStyle(),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
