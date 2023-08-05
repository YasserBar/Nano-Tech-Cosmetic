import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/user_entity.dart';

class UserModel extends User {
  UserModel({
    required String firstName,
    required String lastName,
    required String gender,
    required String birthday,
    required String address,
    required String phone,
    required String email,
    required String? twitter,
    required String? facebook,
    required String? instagram,
    required String? telegram,
    required Role role,
    required String token,
    required String refreshToken,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          gender: gender,
          birthday: birthday,
          address: address,
          phone: phone,
          email: email,
          facebook: facebook,
          twitter: twitter,
          instagram: instagram,
          telegram: telegram,
          role: role,
          token: token,
          refreshToken: refreshToken,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json["data"]['first_name'] as String,
      lastName: json["data"]['last_name'] as String,
      gender: json["data"]['gender'] as String,
      birthday: json["data"]['Birthday'] as String,
      address: json["data"]['address'] as String,
      phone: json["data"]['phone'] as String,
      email: json["data"]['email'] as String,
      facebook: json["data"]['facebook'] as String?,
      twitter: json["data"]['twiter'] as String?,
      instagram: json["data"]['instagram'] as String?,
      telegram: json["data"]['telegram'] as String?,
      role: switchToRole(json['Role'] as String),
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'first_name': firstName,
        'last_name': lastName,
        'gender': gender,
        'Birthday': birthday,
        'address': address,
        'phone': phone,
        'email': email,
        'facebook': facebook,
        'twiter': twitter,
        'instagram': instagram,
        'telegram': telegram,
      },
      'Role': switchFromRole(role),
      'token': token,
      'refreshToken': refreshToken,
    };
  }
}

Role switchToRole(String role) {
  if (role == 'customer') {
    return Role.customer;
  } else if (role == 'salon') {
    return Role.salon;
  } else {
    return Role.company;
  }
}

String switchFromRole(Role role) {
  if (role == Role.customer) {
    return 'customer';
  } else if (role == Role.salon) {
    return 'salon';
  } else {
    return 'company';
  }
}
