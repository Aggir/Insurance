part of 'companies_cubit.dart';

class CompaniesState extends Equatable {
  final Status fetchCompaniesStatus;
  final String? fetchCompaniesErrorMessage;
  final Status fetchMoreCompaniesStatus;
  final String? fetchMoreCompaniesErrorMessage;
  final List<CompanyEntity>? companies;
  final List<CompanyEntity>? filteredCompanies;
  final CompanyEntity? selectedCompany;
  final MetaEntity? meta;
  final Status fetchPricesFormDataStatus;
  final String? fetchPricesFormDataErrorMessage;
  final CompanyPricesFormData? companyPricesFormData;
  final Status calculatePriceStatus;
  final String? calculatePriceErrorMessage;
  final String? price;
  final int? insuranceTypeId;
  final int? vehicleTypeId;
  final bool? withAttachment;

  const CompaniesState({
    this.fetchCompaniesStatus = Status.initial,
    this.fetchCompaniesErrorMessage,
    this.fetchMoreCompaniesStatus = Status.initial,
    this.fetchMoreCompaniesErrorMessage,
    this.companies,
    this.filteredCompanies,
    this.selectedCompany,
    this.meta,
    this.fetchPricesFormDataStatus = Status.initial,
    this.fetchPricesFormDataErrorMessage,
    this.companyPricesFormData,
    this.calculatePriceStatus = Status.initial,
    this.calculatePriceErrorMessage,
    this.price,
    this.insuranceTypeId,
    this.vehicleTypeId,
    this.withAttachment,
  });

  @override
  List<Object?> get props => [
        fetchCompaniesStatus,
        fetchCompaniesErrorMessage,
        fetchMoreCompaniesStatus,
        fetchMoreCompaniesErrorMessage,
        companies,
        filteredCompanies,
        selectedCompany,
        meta,
        fetchPricesFormDataStatus,
        fetchPricesFormDataErrorMessage,
        companyPricesFormData,
        calculatePriceStatus,
        calculatePriceErrorMessage,
        price,
        insuranceTypeId,
        vehicleTypeId,
        withAttachment,
      ];

  CompaniesState copyWith({
    Status? fetchCompaniesStatus,
    String? fetchCompaniesErrorMessage,
    Status? fetchMoreCompaniesStatus,
    String? fetchMoreCompaniesErrorMessage,
    List<CompanyEntity>? companies,
    List<CompanyEntity>? filteredCompanies,
    CompanyEntity? selectedCompany,
    MetaEntity? meta,
    Status? fetchPricesFormDataStatus,
    String? fetchPricesFormDataErrorMessage,
    CompanyPricesFormData? companyPricesFormData,
    Status? calculatePriceStatus,
    String? calculatePriceErrorMessage,
    String? price,
    int? insuranceTypeId,
    int? vehicleTypeId,
    bool? withAttachment,
    bool clearPricesFilter = false,
  }) {
    return CompaniesState(
      fetchCompaniesStatus: fetchCompaniesStatus ?? this.fetchCompaniesStatus,
      fetchCompaniesErrorMessage:
          fetchCompaniesErrorMessage ?? this.fetchCompaniesErrorMessage,
      fetchMoreCompaniesStatus:
          fetchMoreCompaniesStatus ?? this.fetchMoreCompaniesStatus,
      fetchMoreCompaniesErrorMessage:
          fetchMoreCompaniesErrorMessage ?? this.fetchMoreCompaniesErrorMessage,
      companies: companies ?? this.companies,
      filteredCompanies: filteredCompanies ?? this.filteredCompanies,
      selectedCompany: selectedCompany ?? this.selectedCompany,
      meta: meta ?? this.meta,
      fetchPricesFormDataStatus:
          fetchPricesFormDataStatus ?? this.fetchPricesFormDataStatus,
      fetchPricesFormDataErrorMessage: fetchPricesFormDataErrorMessage ??
          this.fetchPricesFormDataErrorMessage,
      companyPricesFormData:
          companyPricesFormData ?? this.companyPricesFormData,
      calculatePriceStatus: clearPricesFilter
          ? Status.initial
          : calculatePriceStatus ?? this.calculatePriceStatus,
      calculatePriceErrorMessage: clearPricesFilter
          ? null
          : calculatePriceErrorMessage ?? this.calculatePriceErrorMessage,
      price: clearPricesFilter ? null : price ?? this.price,
      insuranceTypeId:
          clearPricesFilter ? null : insuranceTypeId ?? this.insuranceTypeId,
      vehicleTypeId:
          clearPricesFilter ? null : vehicleTypeId ?? this.vehicleTypeId,
      withAttachment:
          clearPricesFilter ? null : withAttachment ?? this.withAttachment,
    );
  }

  @override
  String toString() {
    return 'CompaniesState(fetchCompaniesStatus: $fetchCompaniesStatus, fetchCompaniesErrorMessage: $fetchCompaniesErrorMessage, fetchMoreCompaniesStatus: $fetchMoreCompaniesStatus, fetchMoreCompaniesErrorMessage: $fetchMoreCompaniesErrorMessage, companies: $companies, meta: $meta)';
  }
}
