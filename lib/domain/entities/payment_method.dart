import 'package:equatable/equatable.dart';

class PaymentMethod extends Equatable {
  final String id;
  final String name;
  final String imagePath;
  const PaymentMethod({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  @override
  List<Object> get props => [id, name, imagePath];

  PaymentMethod copyWith({
    String? id,
    String? name,
    String? imagePath,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
