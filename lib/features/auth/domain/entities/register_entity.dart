import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final String firstName;
  final String lastName;
  final String gender;
  final String birthday;
  final String address;
  final String phone;
  final String email;
  final String password;
  final String facebook;
  final String twitter;
  final String instagram;
  final String telegram;

  const Register({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthday,
    required this.address,
    required this.phone,
    required this.email,
    required this.password,
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.telegram,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        gender,
        birthday,
        address,
        phone,
        email,
        password,
        facebook,
        twitter,
        instagram,
        telegram,
      ];
}
