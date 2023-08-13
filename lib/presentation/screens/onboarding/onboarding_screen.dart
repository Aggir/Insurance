import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';

import 'package:insurance_app/presentation/theme/app_theme.dart';

import '../../../app/assets_manager.dart';
import '../../../app/di/dependency_injection.dart';
import '../../../app/helpers/app_service.dart';
import '../../../app/router/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_text_button.dart';
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
    instance<AppService>().onboarding = true;
    context.go(AppScreen.termsAndConditions.toPath);
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
                padding: EdgeInsets.fromLTRB(AppValues.medium.r, 0,
                    AppValues.medium.r, AppValues.large.r),
                child: Row(
                  children: [
                    DotsIndicator(
                      dotsCount: _pages.length,
                      position: _pageIndex,
                      decorator: DotsDecorator(
                        color: AppColors.primary.withOpacity(0.3),
                        size: Size(AppSizes.s6.r, AppSizes.s12.r),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        activeColor: AppColors.primary,
                        activeSize: Size(AppSizes.s6.r, AppSizes.s18.r),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
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
                          height: AppSizes.s62.r,
                          width: AppSizes.s62.r,
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
                          height: AppSizes.s62.r,
                          width: AppSizes.s62.r,
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
                        vertical: AppValues.small, horizontal: AppValues.medium)
                    .r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Opacity(
                      opacity: _isSwipingToTheLastPage
                          ? 1 - (_pageIndex - (_pages.length - 2))
                          : 1,
                      child: CustomTextButton(
                        onPressed: _skipFunction,
                        text: AppStrings.skip.tr(),
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
