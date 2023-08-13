import 'dart:io';

import 'package:equatable/equatable.dart';

class NationalDocument extends Equatable {
  final String nationalId;
  final File nationalFile;
  const NationalDocument({
    required this.nationalId,
    required this.nationalFile,
  });

  @override
  List<Object> get props => [nationalId, nationalFile];

  NationalDocument copyWith({
    String? nationalId,
    File? nationalFile,
  }) {
    return NationalDocument(
      nationalId: nationalId ?? this.nationalId,
      nationalFile: nationalFile ?? this.nationalFile,
    );
  }
}
