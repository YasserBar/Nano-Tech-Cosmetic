import 'package:nano_tech_cosmetic/features/auth/domain/entities/verify_otp_entity.dart';

class VerifyOTPModel extends VerifyOTP {
  const VerifyOTPModel(String otp) : super(otp: otp);

  factory VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    return VerifyOTPModel(
      json['otp'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
    };
  }
}
