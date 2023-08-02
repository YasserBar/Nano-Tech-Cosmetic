

import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/login_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/register_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/resend_otp_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/reset_password_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/verify_otp_entity.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final Login login;

  const LoginEvent(this.login);

  @override
  List<Object> get props => [login];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

class VerifyOTPEvent extends AuthEvent {
  final VerifyOTP verifyOTP;

  const VerifyOTPEvent(this.verifyOTP);

  @override
  List<Object> get props => [verifyOTP];
}

class RegisterEvent extends AuthEvent {
  final Register register;
  final Role roll;

  const RegisterEvent(this.register, this.roll);

  @override
  List<Object> get props => [register, roll];
}

class ResendOTPEvent extends AuthEvent {
  final ResendOTP resendOTP;

  const ResendOTPEvent(this.resendOTP);

  @override
  List<Object> get props => [resendOTP];
}

class ResetPasswordEvent extends AuthEvent {
  final ResetPassword resetPassword;

  const ResetPasswordEvent(this.resetPassword);

  @override
  List<Object> get props => [resetPassword];
}


