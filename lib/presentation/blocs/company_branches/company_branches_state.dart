part of 'company_branches_cubit.dart';

class CompanyBranchesState extends Equatable {
  final Status fetchBranchesStatus;
  final String? fetchBranchesErrorMessage;
  final List<BranchEntity>? branches;

  final Status fetchCitiesStatus;
  final String? fetchCitiesErrorMessage;
  final List<CityEntity>? cities;

  const CompanyBranchesState({
    this.fetchBranchesStatus = Status.initial,
    this.fetchBranchesErrorMessage,
    this.branches,
    this.fetchCitiesStatus = Status.initial,
    this.fetchCitiesErrorMessage,
    this.cities,
  });

  @override
  List<Object?> get props => [
        fetchBranchesStatus,
        fetchBranchesErrorMessage,
        branches,
        fetchCitiesStatus,
        fetchCitiesErrorMessage,
        cities,
      ];

  CompanyBranchesState copyWith({
    Status? fetchBranchesStatus,
    String? fetchBranchesErrorMessage,
    List<BranchEntity>? branches,
    Status? fetchCitiesStatus,
    String? fetchCitiesErrorMessage,
    List<CityEntity>? cities,
  }) {
    return CompanyBranchesState(
      fetchBranchesStatus: fetchBranchesStatus ?? this.fetchBranchesStatus,
      fetchBranchesErrorMessage:
          fetchBranchesErrorMessage ?? this.fetchBranchesErrorMessage,
      branches: branches ?? this.branches,
      fetchCitiesStatus: fetchCitiesStatus ?? this.fetchCitiesStatus,
      fetchCitiesErrorMessage:
          fetchCitiesErrorMessage ?? this.fetchCitiesErrorMessage,
      cities: cities ?? this.cities,
    );
  }
}
