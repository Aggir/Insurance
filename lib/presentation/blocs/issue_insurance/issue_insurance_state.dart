part of './issue_insurance_cubit.dart';

class IssueInsuranceState extends Equatable {
  final String? selectedCompany;
  final String? selectedType;
  final String? selectedVehicle;

  const IssueInsuranceState({
    this.selectedCompany,
    this.selectedType,
    this.selectedVehicle,
  });

  @override
  List<Object?> get props => [selectedCompany, selectedType, selectedVehicle];

  IssueInsuranceState copyWith({
    String? selectedCompany,
    String? selectedType,
    String? selectedVehicle,
  }) {
    return IssueInsuranceState(
      selectedCompany: selectedCompany ?? this.selectedCompany,
      selectedType: selectedType ?? this.selectedType,
      selectedVehicle: selectedVehicle ?? this.selectedVehicle,
    );
  }

  @override
  String toString() =>
      'IssueInsuranceState(selectedCompany: $selectedCompany, selectedType: $selectedType, selectedVehicle: $selectedVehicle)';
}
