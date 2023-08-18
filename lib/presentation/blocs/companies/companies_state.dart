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

  const CompaniesState({
    this.fetchCompaniesStatus = Status.initial,
    this.fetchCompaniesErrorMessage,
    this.fetchMoreCompaniesStatus = Status.initial,
    this.fetchMoreCompaniesErrorMessage,
    this.companies,
    this.filteredCompanies,
    this.selectedCompany,
    this.meta,
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
    );
  }

  @override
  String toString() {
    return 'CompaniesState(fetchCompaniesStatus: $fetchCompaniesStatus, fetchCompaniesErrorMessage: $fetchCompaniesErrorMessage, fetchMoreCompaniesStatus: $fetchMoreCompaniesStatus, fetchMoreCompaniesErrorMessage: $fetchMoreCompaniesErrorMessage, companies: $companies, meta: $meta)';
  }
}
