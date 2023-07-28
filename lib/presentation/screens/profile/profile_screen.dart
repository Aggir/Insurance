import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/screens/profile/components/profile_details_state.dart';
import 'package:insurance_app/presentation/screens/profile/components/profile_editing_state.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';

import '../../../app/dummy_data.dart' as DUMMY;
import '../../blocs/profile/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.basic(
        title: AppStrings.myAccount.tr(),
        backButton: () {
          final cubit = BlocProvider.of<ProfileCubit>(context);
          cubit.state.isEditing
              ? cubit.toggleIsEditing()
              : context.go(Routes.moreRoute);
        },
        actions: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state.isEditing) return Container();
              return FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  height: AppSizes.s48.r,
                  width: AppSizes.s48.r,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      BlocProvider.of<ProfileCubit>(context).init();
                      BlocProvider.of<ProfileCubit>(context).toggleIsEditing();
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SvgPicture.asset(
                        SvgAssets.edit,
                        height: AppSizes.s32.r,
                        width: AppSizes.s32.r,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              AppValues.appBarHeight.r -
              AppSizes.s30.r,
          padding: const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
          width: double.infinity,
          child: Column(children: [
            CustomSpacers.large(),
            _profileMainInfo(),
            CustomSpacers.extraLarge(),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state.isEditing) {
                  return const ProfileEditingState();
                } else {
                  return const ProfileDetailsState();
                }
              },
            )
          ]),
        ),
      ),
    );
  }

  Widget _profileMainInfo() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current.editStatus != previous.editStatus,
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: AppSizes.s80.r,
              width: AppSizes.s80.r,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: AppSizes.s40.r,
                    foregroundImage:
                        const AssetImage(ImageAssets.profilePicture),
                  ),
                  //Todo: Add rtl to ltr
                  Positioned(
                    bottom: -AppSizes.s10.r,
                    left: -AppSizes.s10.r,
                    child: SvgPicture.asset(
                      SvgAssets.cameraCircleFilled,
                      height: AppSizes.s32.r,
                      width: AppSizes.s32.r,
                    ),
                  ),
                ],
              ),
            ),
            CustomSpacers.medium(),
            Text(
              '${DUMMY.fistName} ${DUMMY.middleName} ${DUMMY.lastName}',
              style: smallHeadlineStyle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            CustomSpacers.small(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.userId.tr(),
                  style: smallGrayBodyStyle(),
                ),
                Text(
                  DUMMY.id,
                  style: extraSmallHeadlineStyle(),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
