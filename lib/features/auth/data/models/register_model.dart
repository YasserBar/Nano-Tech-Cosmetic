import 'package:nano_tech_cosmetic/features/auth/domain/entities/register_entity.dart';

class RegisterModel extends Register {
  const RegisterModel(
    String firstName,
    String lastName,
    String gender,
    String birthday,
    String address,
    String phone,
    String email,
    String password,
    String facebook,
    String twitter,
    String instagram,
    String telegram,
  ) : super(
          firstName: firstName,
          lastName: lastName,
          gender:gender,
          birthday: birthday,
          address: address,
          phone: phone,
          email: email,
          password: password,
          facebook: facebook,
          twitter: twitter,
          instagram: instagram,
          telegram: telegram,
        );

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      json['email'] as String,
      json['password'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      json['gender'] as String,
      json['Birthday'] as String,
      json['address'] as String,
      json['phone'] as String,
      json['facebook'] as String,
      json['twiter'] as String,
      json['instagram'] as String,
      json['telegram'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'Birthday': birthday,
      'address': address,
      'phone': phone,
      'facebook': facebook,
      'twiter': twitter,
      'instagram': instagram,
      'telegram': telegram,
    };
  }
}
