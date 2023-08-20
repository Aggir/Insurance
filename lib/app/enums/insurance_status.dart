enum InsuranceStatus {
  processing,
  active,
  expire,
}

extension InsuranceStatusExtension on InsuranceStatus {
  bool get isProcessing => this == InsuranceStatus.processing;
  bool get isActive => this == InsuranceStatus.active;
  bool get isExpire => this == InsuranceStatus.expire;
}

extension StringToInsuranceStatusExtension on String {
  InsuranceStatus toInsuranceStatus() {
    switch (toLowerCase()) {
      case 'processing':
        return InsuranceStatus.processing;
      case 'active':
        return InsuranceStatus.active;
      case 'expire':
      default:
        return InsuranceStatus.expire;
    }
  }
}
