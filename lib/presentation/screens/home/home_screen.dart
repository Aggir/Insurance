import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/blocs/home/home_cubit.dart';
import 'package:insurance_app/presentation/blocs/my_insurances/my_insurances_cubit.dart';
import 'package:insurance_app/presentation/blocs/my_vehicles/my_vehicles_cubit.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/font_manager.dart';
import 'package:insurance_app/presentation/theme/styles_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.child, this.location, {super.key});
  final StatefulNavigationShell child;
  final String location;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).init();
    super.initState();
  }

  final List<Map<String, String>> _navBarItems = [
    {
      'label': AppStrings.home.tr(),
      'filledSvgPath': SvgAssets.homeFilled,
      "svgPath": SvgAssets.home,
    },
    {
      'label': AppStrings.myVehicles.tr(),
      'filledSvgPath': SvgAssets.carFilled,
      "svgPath": SvgAssets.car,
    },
    {
      'label': AppStrings.myInsurances.tr(),
      'filledSvgPath': SvgAssets.shieldFilled,
      "svgPath": SvgAssets.shield,
    },
    {
      'label': AppStrings.more.tr(),
      'filledSvgPath': SvgAssets.moreFilled,
      "svgPath": SvgAssets.more,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: SizedBox(
        height: AppSizes.s86.r,
        child: BottomNavigationBar(
          backgroundColor: AppColors.white,
          currentIndex: widget.child.currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.blackText,
          unselectedItemColor: AppColors.gray,
          selectedLabelStyle:
              getBoldStyle(color: AppColors.blackText, fontSize: FontSize.s10),
          unselectedLabelStyle:
              getRegularStyle(color: AppColors.gray, fontSize: FontSize.s10),
          onTap: (value) {
            if (value == 0) {
              context.go(AppScreen.home.toPath);
              return;
            } else if (value == 1) {
              BlocProvider.of<MyVehiclesCubit>(context).init();
            } else if (value == 2) {
              BlocProvider.of<MyInsurancesCubit>(context).init();
            }
            widget.child.goBranch(value);
          },
          items: _navBarItems
              .map((item) => navBarItem(
                    label: item['label']!,
                    filledSvgPath: item['filledSvgPath']!,
                    svgPath: item['svgPath']!,
                  ))
              .toList(),
        ),
      ),
    );
  }

  BottomNavigationBarItem navBarItem(
      {required String label,
      required String filledSvgPath,
      required String svgPath}) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        svgPath,
        height: AppSizes.s28.r,
        width: AppSizes.s28.r,
      ),
      tooltip: label,
      activeIcon: SvgPicture.asset(
        filledSvgPath,
        height: AppSizes.s28.r,
        width: AppSizes.s28.r,
      ),
      label: label,
    );
  }
}
