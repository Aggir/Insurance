import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';

import '../../../app/assets_manager.dart';
import '../../theme/app_colors.dart';
import 'components/onboarding_page_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  double _pageIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'imgBackgroundColor': AppColors.primaryLightest,
      'imgPath': ImageAssets.onboardingOne,
      'header': AppStrings.onboardingOneHeader,
      'description': AppStrings.onboardingOneDescription,
    },
    {
      'imgBackgroundColor': AppColors.primaryLightest,
      'imgPath': ImageAssets.onboardingTwo,
      'header': AppStrings.onboardingTwoHeader,
      'description': AppStrings.onboardingTwoDescription,
    },
    {
      'imgBackgroundColor': AppColors.secondaryLight,
      'imgPath': ImageAssets.onboardingThree,
      'header': AppStrings.onboardingThreeHeader,
      'description': AppStrings.onboardingThreeDescription,
    },
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
      (_pageIndex + 1).round(),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _doneFunction() {
    context.go(Routes.termsAndConditionsRoute);
  }

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _pageIndex = _controller.page ?? 0;
      });
    });
    super.initState();
  }

  bool get _isSwipingToTheLastPage => _pageIndex.ceil() == _pages.length - 1;
  bool get _halfSwipeToTheLastPage => (_pageIndex - (_pages.length - 2)) >= 0.5;
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
                child: PageView.builder(
                  controller: _controller,
                  itemBuilder: (context, index) => OnboardingPageContent(
                    imgPath: _pages[index]['imgPath'],
                    imgBackgroundColor: _pages[index]['imgBackgroundColor'],
                    header: _pages[index]['header'],
                    description: _pages[index]['description'],
                  ),
                  itemCount: _pages.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppValues.medium, 0, AppValues.medium, AppValues.large),
                child: Row(
                  children: [
                    DotsIndicator(
                      dotsCount: _pages.length,
                      position: _pageIndex,
                      decorator: DotsDecorator(
                        color: AppColors.primary.withOpacity(0.3),
                        size: const Size(AppSizes.s6, AppSizes.s12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        activeColor: AppColors.primary,
                        activeSize: const Size(AppSizes.s6, AppSizes.s18),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (!_halfSwipeToTheLastPage)
                      Opacity(
                        opacity: _isSwipingToTheLastPage
                            ? 1 - (_pageIndex - (_pages.length - 2)) * 2
                            : 1,
                        child: SizedBox(
                          height: AppSizes.s62,
                          width: AppSizes.s62,
                          child: ElevatedButton(
                            onPressed: _nextFunction,
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: AppColors.primary,
                            ),
                            child: SvgPicture.asset(SvgAssets.chevronLeft),
                          ),
                        ),
                      ),
                    if (_halfSwipeToTheLastPage)
                      Opacity(
                        opacity: _isSwipingToTheLastPage
                            ? (_pageIndex - (_pages.length - 2))
                            : 1,
                        child: SizedBox(
                          height: AppSizes.s62,
                          width: AppSizes.s62,
                          child: ElevatedButton(
                            onPressed: _doneFunction,
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: AppColors.secondary),
                            child: SvgPicture.asset(SvgAssets.checkMark),
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
                    Opacity(
                      opacity: _isSwipingToTheLastPage
                          ? 1 - (_pageIndex - (_pages.length - 2))
                          : 1,
                      child: TextButton(
                        onPressed: _skipFunction,
                        child: Text(
                          AppStrings.skip.tr(),
                          style: textButtonStyle(),
                        ),
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
