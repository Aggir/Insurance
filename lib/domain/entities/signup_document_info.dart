import 'package:equatable/equatable.dart';

class SignUpDocumentInfo extends Equatable {
  final String type;
  final String documentNumber;
  final String? issuingPlace;
  final String? dateOfIssue;
  final String? dateOfExpiry;
  const SignUpDocumentInfo({
    required this.type,
    required this.documentNumber,
    this.issuingPlace,
    this.dateOfIssue,
    this.dateOfExpiry,
  });

  SignUpDocumentInfo copyWith({
    String? type,
    String? documentNumber,
    String? issuingPlace,
    String? dateOfIssue,
    String? dateOfExpiry,
  }) {
    return SignUpDocumentInfo(
      type: type ?? this.type,
      documentNumber: documentNumber ?? this.documentNumber,
      issuingPlace: issuingPlace ?? this.issuingPlace,
      dateOfIssue: dateOfIssue ?? this.dateOfIssue,
      dateOfExpiry: dateOfExpiry ?? this.dateOfExpiry,
    );
  }

  @override
  List<Object?> get props => [
        type,
        documentNumber,
        issuingPlace,
        dateOfIssue,
        dateOfExpiry,
      ];
}
