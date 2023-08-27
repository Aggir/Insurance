part of 'compare_companies_cubit.dart';

class CompareCompaniesState extends Equatable {
  final Status fetchInsuranceTypesStatus;
  final String? fetchInsuranceTypesErrorMessage;
  final List<InsuranceTypeEntity>? insuranceTypes;
  final int? insuranceTypeId;
  final int? horsePower;
  final int? maxPassengers;
  final bool isSortByMinimum;
  final Status fetchCompaniesPricesStatus;
  final String? fetchCompaniesPricesErrorMessage;
  final List<CompanyPriceEntity>? companiesPrices;
  final List<CompanyPriceEntity>? filteredCompaniesPrices;

  const CompareCompaniesState({
    this.fetchInsuranceTypesStatus = Status.initial,
    this.fetchInsuranceTypesErrorMessage,
    this.insuranceTypes,
    this.insuranceTypeId,
    this.horsePower,
    this.maxPassengers,
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
    int? insuranceTypeId,
    int? horsePower,
    int? maxPassengers,
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
      insuranceTypeId: insuranceTypeId ?? this.insuranceTypeId,
      horsePower: horsePower ?? this.horsePower,
      maxPassengers: maxPassengers ?? this.maxPassengers,
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
      insuranceTypeId,
      horsePower,
      maxPassengers,
      isSortByMinimum,
      fetchCompaniesPricesStatus,
      fetchCompaniesPricesErrorMessage,
      companiesPrices,
      filteredCompaniesPrices,
    ];
  }

  @override
  String toString() {
    return 'CompareCompaniesState(fetchInsuranceTypesStatus: $fetchInsuranceTypesStatus, fetchInsuranceTypesErrorMessage: $fetchInsuranceTypesErrorMessage, insuranceTypes: $insuranceTypes, insuranceTypeId: $insuranceTypeId, horsePower: $horsePower, maxPassengers: $maxPassengers, isSortByMinimum: $isSortByMinimum, fetchCompaniesPricesStatus: $fetchCompaniesPricesStatus, fetchCompaniesPricesErrorMessage: $fetchCompaniesPricesErrorMessage, companiesPrices: $companiesPrices, filteredCompaniesPrices: $filteredCompaniesPrices)';
  }
}
