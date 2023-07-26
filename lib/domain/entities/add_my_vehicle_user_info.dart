import 'package:equatable/equatable.dart' show Equatable;

class AddMyVehicleUserInfo extends Equatable {
  final String firstName;
  final String middleName;
  final String lastName;
  final String address;
  final String phoneNumber;
  const AddMyVehicleUserInfo({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.address,
    required this.phoneNumber,
  });

  AddMyVehicleUserInfo copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? address,
    String? phoneNumber,
  }) {
    return AddMyVehicleUserInfo(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        address,
        phoneNumber,
      ];

  @override
  String toString() {
    return 'AddMyVehicleUserInfo(firstName: $firstName, middleName: $middleName, lastName: $lastName, address: $address, phoneNumber: $phoneNumber)';
  }
}
