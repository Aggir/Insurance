import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:insurance_app/app/enums/proof_type.dart';

class ProofDocument extends Equatable {
  final ProofType proofType;
  final File proofFile;
  final String proofId;
  final String issuePlace;
  final String issueDate;
  final String expirationDate;
  const ProofDocument({
    required this.proofType,
    required this.proofFile,
    required this.proofId,
    required this.issuePlace,
    required this.issueDate,
    required this.expirationDate,
  });

  @override
  List<Object?> get props => [
        proofType,
        proofFile,
        proofId,
        issuePlace,
        issueDate,
        expirationDate,
      ];

  ProofDocument copyWith({
    ProofType? proofType,
    File? proofFile,
    String? proofId,
    String? issuePlace,
    String? issueDate,
    String? expirationDate,
  }) {
    return ProofDocument(
      proofType: proofType ?? this.proofType,
      proofFile: proofFile ?? this.proofFile,
      proofId: proofId ?? this.proofId,
      issuePlace: issuePlace ?? this.issuePlace,
      issueDate: issueDate ?? this.issueDate,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  @override
  String toString() {
    return 'ProofDocument(proofType: $proofType, proofFile: $proofFile, proofId: $proofId, issuePlace: $issuePlace, issueDate: $issueDate, expirationDate: $expirationDate)';
  }
}
