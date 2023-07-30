import 'package:nano_tech_cosmetic/features/auth/domain/entities/resend_otp_entity.dart';

class ResendOTPModel extends ResendOTP {
  const ResendOTPModel(String email) : super(email: email);

  factory ResendOTPModel.fromJson(Map<String, dynamic> json) {
    return ResendOTPModel(
      json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
