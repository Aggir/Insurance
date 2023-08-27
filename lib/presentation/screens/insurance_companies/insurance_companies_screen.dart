import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/company.dart';

import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';

import '../../../app/assets_manager.dart';
import '../../../app/router/routes.dart';
import '../../blocs/companies/companies_cubit.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_text_form_field.dart';

class InsuranceCompaniesScreen extends StatefulWidget {
  const InsuranceCompaniesScreen({super.key});

  @override
  State<InsuranceCompaniesScreen> createState() =>
      _InsuranceCompaniesScreenState();
}

class _InsuranceCompaniesScreenState extends State<InsuranceCompaniesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompaniesCubit>(context).fetchCompanies();
  }

  void goBack() {
    BlocProvider.of<CompaniesCubit>(context).clearSearch();
    context.go(AppScreen.carsInsurance.toPath);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CompaniesCubit>(context);
    return WillPopScope(
      onWillPop: () async {
        goBack();
        return false;
      },
      child: GestureDetector(
        onTap: () {
          cubit.searchFocusNode.unfocus();
        },
        child: Scaffold(
          appBar: CustomAppBar.basic(
              title: AppStrings.insuranceCompanies.tr(), backButton: goBack),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppValues.medium).r,
                child: CustomTextFormField(
                  controller: cubit.searchController,
                  onChanged: cubit.setFilterCompanies,
                  focusNode: cubit.searchFocusNode,
                  hintText: AppStrings.search.tr(),
                  prefixIcon: SvgPicture.asset(
                    SvgAssets.search,
                    height: AppSizes.s24.r,
                    width: AppSizes.s24.r,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<CompaniesCubit, CompaniesState>(
                  builder: (context, state) {
                    if (state.fetchCompaniesStatus.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    } else {
                      return Stack(
                        children: [
                          ListView.separated(
                            controller: cubit.scrollController,
                            separatorBuilder: (context, index) =>
                                CustomSpacers.medium(),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(AppValues.medium).r,
                            itemCount: state.filteredCompanies?.length ?? 0,
                            itemBuilder: (context, index) => _companyCardWidget(
                                cubit.searchFocusNode, context,
                                company: state.filteredCompanies![index]),
                          ),
                          if (state.fetchMoreCompaniesStatus.isLoading)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: CircleAvatar(
                                backgroundColor: AppColors.lightest,
                                radius: AppSizes.s20.r,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(AppValues.small).r,
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                    strokeWidth: AppSizes.s4.r,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _companyCardWidget(
    FocusNode focusNode,
    BuildContext context, {
    required CompanyEntity company,
  }) {
    return Stack(
      key: ValueKey(company.id),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
                  vertical: AppValues.medium, horizontal: AppValues.medium)
              .r,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
              color: AppColors.white,
              boxShadow: [AppValues.boxShadow]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(AppValues.mediumRadius.r),
                          border: Border.all(color: AppColors.grayLight),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: company.photo,
                          height: AppSizes.s64.r,
                          width: AppSizes.s64.r,
                        ),
                      ),
                      CustomSpacers.medium(),
                      SizedBox(
                        width: AppSizes.s200.r,
                        child: Text(
                          company.name,
                          style: mediumSmallHeadlineStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                            vertical: AppValues.medium,
                            horizontal: AppValues.small)
                        .r,
                    decoration: BoxDecoration(
                        color: AppColors.lightest,
                        borderRadius:
                            BorderRadius.circular(AppValues.mediumRadius),
                        border: Border.all(color: AppColors.grayLight)),
                    child: SvgPicture.asset(
                      SvgAssets.chevronLeft,
                      height: AppSizes.s22.r,
                      width: AppSizes.s22.r,
                      colorFilter:
                          ColorFilter.mode(AppColors.gray, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
              CustomSpacers.medium(),
              Text(
                company.description,
                style: smallGrayBodyStyle(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                focusNode.unfocus();
                BlocProvider.of<CompaniesCubit>(context).selectCompany(company);
                context.go(
                  '${AppScreen.companyDetails.toPath}${company.id}',
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
