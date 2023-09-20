part of './issue_insurance_cubit.dart';

class IssueInsuranceState extends Equatable {
  final Status fetchInsuranceFormDataStatus;
  final String? fetchInsuranceFormDataErrorMessage;
  final IssueInsuranceFormData? insuranceFormData;
  final Status calculateInsurancePriceStatus;
  final String? calculateInsurancePriceErrorMessage;
  final String? insurancePrice;
  final Status issueInsuranceStatus;
  final String? issueInsuranceErrorMessage;
  final int? selectedCompanyId;
  final int? selectedTypeId;
  final int? selectedVehicleId;
  final InsuranceEntity? insurance;
  final int? selectedInsurancePeriod;

  const IssueInsuranceState({
    this.fetchInsuranceFormDataStatus = Status.initial,
    this.fetchInsuranceFormDataErrorMessage,
    this.insuranceFormData,
    this.calculateInsurancePriceStatus = Status.initial,
    this.calculateInsurancePriceErrorMessage,
    this.insurancePrice,
    this.issueInsuranceStatus = Status.initial,
    this.issueInsuranceErrorMessage,
    this.selectedCompanyId,
    this.selectedTypeId,
    this.selectedVehicleId,
    this.insurance,
    this.selectedInsurancePeriod = 1,
  });

  @override
  List<Object?> get props => [
        selectedCompanyId,
        selectedTypeId,
        selectedVehicleId,
        fetchInsuranceFormDataStatus,
        fetchInsuranceFormDataErrorMessage,
        insuranceFormData,
        calculateInsurancePriceStatus,
        calculateInsurancePriceErrorMessage,
        issueInsuranceStatus,
        issueInsuranceErrorMessage,
        insurancePrice,
        insurance,
        selectedInsurancePeriod,
      ];

  IssueInsuranceState copyWith({
    Status? fetchInsuranceFormDataStatus,
    String? fetchInsuranceFormDataErrorMessage,
    IssueInsuranceFormData? insuranceFormData,
    Status? calculateInsurancePriceStatus,
    String? calculateInsurancePriceErrorMessage,
    String? insurancePrice,
    Status? issueInsuranceStatus,
    String? issueInsuranceErrorMessage,
    int? selectedCompanyId,
    int? selectedTypeId,
    int? selectedVehicleId,
    InsuranceEntity? insurance,
    int? selectedInsurancePeriod,
  }) {
    return IssueInsuranceState(
      fetchInsuranceFormDataStatus:
          fetchInsuranceFormDataStatus ?? this.fetchInsuranceFormDataStatus,
      fetchInsuranceFormDataErrorMessage: fetchInsuranceFormDataErrorMessage ??
          this.fetchInsuranceFormDataErrorMessage,
      insuranceFormData: insuranceFormData ?? this.insuranceFormData,
      selectedCompanyId: selectedCompanyId ?? this.selectedCompanyId,
      calculateInsurancePriceStatus:
          calculateInsurancePriceStatus ?? this.calculateInsurancePriceStatus,
      calculateInsurancePriceErrorMessage:
          calculateInsurancePriceErrorMessage ??
              this.calculateInsurancePriceErrorMessage,
      insurancePrice: insurancePrice ?? this.insurancePrice,
      issueInsuranceStatus: issueInsuranceStatus ?? this.issueInsuranceStatus,
      issueInsuranceErrorMessage:
          issueInsuranceErrorMessage ?? this.issueInsuranceErrorMessage,
      selectedTypeId: selectedTypeId ?? this.selectedTypeId,
      selectedVehicleId: selectedVehicleId ?? this.selectedVehicleId,
      insurance: insurance ?? this.insurance,
      selectedInsurancePeriod:
          selectedInsurancePeriod ?? this.selectedInsurancePeriod,
    );
  }

  @override
  String toString() =>
      'IssueInsuranceState(selectedCompany: $selectedCompanyId, selectedType: $selectedTypeId, selectedVehicle: $selectedVehicleId)';
}
