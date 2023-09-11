part of 'compare_companies_cubit.dart';

class CompareCompaniesState extends Equatable {
  final Status fetchPricesFormDataStatus;
  final String? fetchPricesFormDataErrorMessage;
  final CompanyPricesFormData? companyPricesFormData;
  final int? selectedInsuranceTypeId;
  final int? selectedVehicleTypeId;
  final bool? withAttachment;
  final bool isSortByMinimum;
  final Status fetchCompaniesPricesStatus;
  final String? fetchCompaniesPricesErrorMessage;
  final List<CompanyPriceEntity>? companiesPrices;
  final List<CompanyPriceEntity>? filteredCompaniesPrices;

  const CompareCompaniesState({
    this.fetchPricesFormDataStatus = Status.initial,
    this.fetchPricesFormDataErrorMessage,
    this.companyPricesFormData,
    this.selectedInsuranceTypeId,
    this.selectedVehicleTypeId,
    this.withAttachment,
    this.isSortByMinimum = true,
    this.fetchCompaniesPricesStatus = Status.initial,
    this.fetchCompaniesPricesErrorMessage,
    this.companiesPrices,
    this.filteredCompaniesPrices,
  });

  CompareCompaniesState copyWith({
    Status? fetchPricesFormDataStatus,
    String? fetchPricesFormDataErrorMessage,
    CompanyPricesFormData? companyPricesFormData,
    int? selectedInsuranceTypeId,
    int? selectedVehicleTypeId,
    bool? withAttachment,
    bool? isSortByMinimum,
    bool clearFilter = false,
    Status? fetchCompaniesPricesStatus,
    String? fetchCompaniesPricesErrorMessage,
    List<CompanyPriceEntity>? companiesPrices,
    List<CompanyPriceEntity>? filteredCompaniesPrices,
  }) {
    return CompareCompaniesState(
      fetchPricesFormDataStatus:
          fetchPricesFormDataStatus ?? this.fetchPricesFormDataStatus,
      fetchPricesFormDataErrorMessage: fetchPricesFormDataErrorMessage ??
          this.fetchPricesFormDataErrorMessage,
      companyPricesFormData:
          companyPricesFormData ?? this.companyPricesFormData,
      selectedInsuranceTypeId: clearFilter
          ? null
          : selectedInsuranceTypeId ?? this.selectedInsuranceTypeId,
      selectedVehicleTypeId: clearFilter
          ? null
          : selectedVehicleTypeId ?? this.selectedVehicleTypeId,
      withAttachment:
          clearFilter ? null : withAttachment ?? this.withAttachment,
      isSortByMinimum:
          clearFilter ? true : (isSortByMinimum ?? this.isSortByMinimum),
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
      fetchPricesFormDataStatus,
      fetchPricesFormDataErrorMessage,
      companyPricesFormData,
      selectedInsuranceTypeId,
      selectedVehicleTypeId,
      withAttachment,
      isSortByMinimum,
      fetchCompaniesPricesStatus,
      fetchCompaniesPricesErrorMessage,
      companiesPrices,
      filteredCompaniesPrices,
    ];
  }
}
