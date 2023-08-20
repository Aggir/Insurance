part of 'my_insurances_cubit.dart';

class MyInsurancesState extends Equatable {
  final Status fetchInsurancesStatus;
  final String? fetchInsurancesErrorMessage;
  final List<InsuranceEntity>? insurances;
  final MetaEntity? meta;
  final List<InsuranceEntity>? processingInsurances;
  final List<InsuranceEntity>? activeInsurances;
  final List<InsuranceEntity>? notPaidInsurances;
  final List<InsuranceEntity>? expiredInsurances;
  final Status fetchMoreInsurancesStatus;
  final String? fetchMoreInsurancesErrorMessage;

  const MyInsurancesState({
    this.fetchInsurancesStatus = Status.initial,
    this.fetchInsurancesErrorMessage,
    this.insurances,
    this.meta,
    this.processingInsurances,
    this.activeInsurances,
    this.notPaidInsurances,
    this.expiredInsurances,
    this.fetchMoreInsurancesStatus = Status.initial,
    this.fetchMoreInsurancesErrorMessage,
  });

  @override
  List<Object?> get props => [
        fetchInsurancesStatus,
        fetchInsurancesErrorMessage,
        insurances,
        meta,
        processingInsurances,
        activeInsurances,
        notPaidInsurances,
        expiredInsurances,
        fetchMoreInsurancesStatus,
        fetchMoreInsurancesErrorMessage,
      ];

  MyInsurancesState copyWith({
    Status? fetchInsurancesStatus,
    String? fetchInsurancesErrorMessage,
    List<InsuranceEntity>? insurances,
    MetaEntity? meta,
    List<InsuranceEntity>? processingInsurances,
    List<InsuranceEntity>? activeInsurances,
    List<InsuranceEntity>? notPaidInsurances,
    List<InsuranceEntity>? expiredInsurances,
    Status? fetchMoreInsurancesStatus,
    String? fetchMoreInsurancesErrorMessage,
  }) {
    return MyInsurancesState(
      fetchInsurancesStatus:
          fetchInsurancesStatus ?? this.fetchInsurancesStatus,
      fetchInsurancesErrorMessage:
          fetchInsurancesErrorMessage ?? this.fetchInsurancesErrorMessage,
      insurances: insurances ?? this.insurances,
      meta: meta ?? this.meta,
      processingInsurances: processingInsurances ?? this.processingInsurances,
      activeInsurances: activeInsurances ?? this.activeInsurances,
      notPaidInsurances: notPaidInsurances ?? this.notPaidInsurances,
      expiredInsurances: expiredInsurances ?? this.expiredInsurances,
      fetchMoreInsurancesStatus:
          fetchMoreInsurancesStatus ?? this.fetchMoreInsurancesStatus,
      fetchMoreInsurancesErrorMessage: fetchMoreInsurancesErrorMessage ??
          this.fetchMoreInsurancesErrorMessage,
    );
  }
}
