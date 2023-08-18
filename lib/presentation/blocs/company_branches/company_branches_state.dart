part of 'company_branches_cubit.dart';

class CompanyBranchesState extends Equatable {
  final Status fetchBranchesStatus;
  final String? fetchBranchesErrorMessage;
  final List<BranchEntity>? branches;

  const CompanyBranchesState({
    this.fetchBranchesStatus = Status.initial,
    this.fetchBranchesErrorMessage,
    this.branches,
  });

  @override
  List<Object?> get props => [
        fetchBranchesStatus,
        fetchBranchesErrorMessage,
        branches,
      ];

  CompanyBranchesState copyWith({
    Status? fetchBranchesStatus,
    String? fetchBranchesErrorMessage,
    List<BranchEntity>? branches,
  }) {
    return CompanyBranchesState(
      fetchBranchesStatus: fetchBranchesStatus ?? this.fetchBranchesStatus,
      fetchBranchesErrorMessage:
          fetchBranchesErrorMessage ?? this.fetchBranchesErrorMessage,
      branches: branches ?? this.branches,
    );
  }
}
