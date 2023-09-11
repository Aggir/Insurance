part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Status fetchCompaniesCountStatus;
  final String? fetchCompaniesCountErrorMessage;
  final int? companiesCount;

  const HomeState({
    this.fetchCompaniesCountStatus = Status.initial,
    this.fetchCompaniesCountErrorMessage,
    this.companiesCount,
  });

  @override
  List<Object?> get props => [
        fetchCompaniesCountStatus,
        fetchCompaniesCountErrorMessage,
        companiesCount,
      ];

  HomeState copyWith({
    Status? fetchCompaniesCountStatus,
    String? fetchCompaniesCountErrorMessage,
    int? companiesCount,
  }) {
    return HomeState(
      fetchCompaniesCountStatus:
          fetchCompaniesCountStatus ?? this.fetchCompaniesCountStatus,
      fetchCompaniesCountErrorMessage: fetchCompaniesCountErrorMessage ??
          this.fetchCompaniesCountErrorMessage,
      companiesCount: companiesCount ?? this.companiesCount,
    );
  }
}
