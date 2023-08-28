import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/constants.dart';

import 'package:insurance_app/presentation/screens/profile/components/profile_details_state.dart';
import 'package:insurance_app/presentation/screens/profile/components/profile_editing_state.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/font_manager.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import '../../../app/router/routes.dart';
import '../../blocs/profile/profile_cubit.dart';
import '../../blocs/user/user_cubit.dart';
import '../../theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void goBack() {
    final cubit = BlocProvider.of<ProfileCubit>(context);
    cubit.state.isEditing
        ? cubit.toggleIsEditing()
        : context.go(AppScreen.more.toPath);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        goBack();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar.basic(
          title: AppStrings.myAccount.tr(),
          backButton: goBack,
          actions: [
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state.isEditing) return Container();
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(
                    height: AppSizes.s48.r,
                    width: AppSizes.s48.r,
                    child: BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            BlocProvider.of<ProfileCubit>(context).init(
                              state.user!.firstName,
                              state.user!.fatherName,
                              state.user!.lastName,
                              state.user!.email,
                              state.user!.phone,
                              state.user!.phoneCode,
                              state.user!.dateOfBirth,
                            );
                            BlocProvider.of<ProfileCubit>(context)
                                .toggleIsEditing();
                          },
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SvgPicture.asset(
                              SvgAssets.edit,
                              height: AppSizes.s32.r,
                              width: AppSizes.s32.r,
                            ),
                          ),
                        );
                      },
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
      ),
    );
  }

  Widget _profileMainInfo() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            return Column(
              children: [
                SizedBox(
                  height: AppSizes.s80.r,
                  width: AppSizes.s80.r,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(100),
                        clipBehavior: Clip.antiAlias,
                        color: AppColors.primaryLight,
                        child: InkWell(
                          onTap: state.isEditing
                              ? () => BlocProvider.of<ProfileCubit>(context)
                                  .pickPhoto()
                              : null,
                          child: SizedBox(
                            height: AppSizes.s80.r,
                            width: AppSizes.s80.r,
                            child: state.photoFile != null
                                ? Image.file(
                                    state.photoFile!,
                                    fit: BoxFit.cover,
                                  )
                                : userState.user != null
                                    ? userState.user!.imageUrl.isNotEmpty
                                        ? CachedNetworkImage(
                                            cacheKey: userState.user!.updatedAt,
                                            imageUrl: userState.user!.imageUrl,
                                          )
                                        : Center(
                                            child: Text(
                                              userState.user!.firstName[0],
                                              style: boldBlackLargeStyle()
                                                  .copyWith(
                                                      fontSize: FontSize.s28),
                                            ),
                                          )
                                    : Container(),
                          ),
                        ),
                      ),
                      //Todo: Add rtl to ltr
                      if (state.isEditing)
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
                  '${userState.user?.firstName} ${userState.user?.fatherName} ${userState.user?.lastName}',
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
                      userState.user?.uniqueId.toString() ?? Constants.empty,
                      style: extraSmallHeadlineStyle(),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
