import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/domain/entities/company_price.dart';
import 'package:insurance_app/presentation/blocs/compare_companies/compare_companies_cubit.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../app/assets_manager.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_text_form_field.dart';
import 'components/filter_insurance_companies_modal.dart';

class ComparePricesScreen extends StatelessWidget {
  const ComparePricesScreen({super.key});

  void _issueAnInsuranceFunction(BuildContext context) {
    context.go(AppScreen.issueInsurance.toPath);
  }

  void goBack(BuildContext context) {
    context.go(AppScreen.vehiclesInsurance.toPath);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CompareCompaniesCubit>(context);
    return BlocBuilder<CompareCompaniesCubit, CompareCompaniesState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            goBack(context);
            return false;
          },
          child: GestureDetector(
            onTap: () {
              cubit.searchFocusNode.unfocus();
            },
            child: Scaffold(
              appBar: CustomAppBar.basic(
                  title: AppStrings.insurancePolicyPrices.tr(),
                  backButton: () => goBack(context),
                  actions: [_filterButton(context)]),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppValues.medium).r,
                    child: CustomTextFormField(
                      focusNode: cubit.searchFocusNode,
                      controller: cubit.searchController,
                      onChanged: cubit.setFilterCompaniesPrices,
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
                    child: BlocBuilder<CompareCompaniesCubit,
                        CompareCompaniesState>(
                      builder: (context, state) {
                        if (state.fetchCompaniesPricesStatus.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          );
                        } else {
                          return ListView.separated(
                            padding: const EdgeInsets.all(AppValues.medium).r,
                            separatorBuilder: (context, index) =>
                                CustomSpacers.medium(),
                            shrinkWrap: true,
                            itemCount:
                                state.filteredCompaniesPrices?.length ?? 0,
                            itemBuilder: (context, index) => _companyCardWidget(
                              context,
                              state.filteredCompaniesPrices![index],
                            ),
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
      },
    );
  }

  Widget _filterButton(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        height: AppSizes.s48.r,
        width: AppSizes.s48.r,
        child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: AppValues.modalShape,
                builder: (context) => BlocProvider.value(
                  value: instance<CompareCompaniesCubit>(),
                  child: const FilterInsuranceCompaniesModal(
                      isComparePricesShown: true),
                ),
              );
            },
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SvgPicture.asset(
                SvgAssets.filter,
                height: AppSizes.s32.r,
                width: AppSizes.s32.r,
              ),
            )),
      ),
    );
  }

  Widget _companyCardWidget(
      BuildContext context, CompanyPriceEntity companyPrice) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppValues.medium).r,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
          color: AppColors.white,
          boxShadow: [AppValues.boxShadow]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
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
                            imageUrl: companyPrice.company.photo,
                            height: AppSizes.s64.r,
                            width: AppSizes.s64.r,
                          ),
                        ),
                        CustomSpacers.medium(),
                        SizedBox(
                          width: AppSizes.s200.r,
                          child: Text(
                            companyPrice.company.name,
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
                  companyPrice.company.description,
                  style: smallGrayBodyStyle(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          CustomSpacers.medium(),
          const CustomDivider(),
          CustomSpacers.medium(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      AppStrings.price.tr(),
                      style: smallGrayBodyStyle(),
                    ),
                    CustomSpacers.small(),
                    Text(
                      '${companyPrice.price} ${AppStrings.currency.tr()}',
                      style: mediumExBoldStyle(),
                    )
                  ],
                ),
                PrimaryButton(
                  onPressed: () => _issueAnInsuranceFunction(context),
                  child: Text(AppStrings.issueAnInsurance.tr()),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
