part of 'compare_companies_cubit.dart';

class CompareCompaniesState extends Equatable {
  final Status fetchInsuranceTypesStatus;
  final String? fetchInsuranceTypesErrorMessage;
  final List<InsuranceTypeEntity>? insuranceTypes;
  final int? selectedInsuranceTypeId;
  final bool? withAttachment;
  final bool isSortByMinimum;
  final Status fetchCompaniesPricesStatus;
  final String? fetchCompaniesPricesErrorMessage;
  final List<CompanyPriceEntity>? companiesPrices;
  final List<CompanyPriceEntity>? filteredCompaniesPrices;

  const CompareCompaniesState({
    this.fetchInsuranceTypesStatus = Status.initial,
    this.fetchInsuranceTypesErrorMessage,
    this.insuranceTypes,
    this.selectedInsuranceTypeId,
    this.withAttachment,
    this.isSortByMinimum = true,
    this.fetchCompaniesPricesStatus = Status.initial,
    this.fetchCompaniesPricesErrorMessage,
    this.companiesPrices,
    this.filteredCompaniesPrices,
  });

  CompareCompaniesState copyWith({
    Status? fetchInsuranceTypesStatus,
    String? fetchInsuranceTypesErrorMessage,
    List<InsuranceTypeEntity>? insuranceTypes,
    int? selectedInsuranceTypeId,
    bool? withAttachment,
    bool? isSortByMinimum,
    Status? fetchCompaniesPricesStatus,
    String? fetchCompaniesPricesErrorMessage,
    List<CompanyPriceEntity>? companiesPrices,
    List<CompanyPriceEntity>? filteredCompaniesPrices,
  }) {
    return CompareCompaniesState(
      fetchInsuranceTypesStatus:
          fetchInsuranceTypesStatus ?? this.fetchInsuranceTypesStatus,
      fetchInsuranceTypesErrorMessage: fetchInsuranceTypesErrorMessage ??
          this.fetchInsuranceTypesErrorMessage,
      insuranceTypes: insuranceTypes ?? this.insuranceTypes,
      selectedInsuranceTypeId:
          selectedInsuranceTypeId ?? this.selectedInsuranceTypeId,
      withAttachment: withAttachment ?? this.withAttachment,
      isSortByMinimum: isSortByMinimum ?? this.isSortByMinimum,
      fetchCompaniesPricesStatus:
          fetchCompaniesPricesStatus ?? this.fetchCompaniesPricesStatus,
      fetchCompaniesPricesErrorMessage: fetchCompaniesPricesErrorMessage ??
          this.fetchCompaniesPricesErrorMessage,
      companiesPrices: companiesPrices ?? this.companiesPrices,
      filteredCompaniesPrices:
          filteredCompaniesPrices ?? this.filteredCompaniesPrices,
    );
  }

  @override
  List<Object?> get props {
    return [
      fetchInsuranceTypesStatus,
      fetchInsuranceTypesErrorMessage,
      insuranceTypes,
      selectedInsuranceTypeId,
      withAttachment,
      isSortByMinimum,
      fetchCompaniesPricesStatus,
      fetchCompaniesPricesErrorMessage,
      companiesPrices,
      filteredCompaniesPrices,
    ];
  }
}
