import 'package:nano_tech_cosmetic/features/auth/domain/entities/reset_password_entity.dart';

class ResetPasswordModel extends ResetPassword {
  const ResetPasswordModel(String password) : super(password: password);

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'password': password,
    };
  }
}
