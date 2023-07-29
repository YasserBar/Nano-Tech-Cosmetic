import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/constants/enum_roll.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/login_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/register_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/resend_otp_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/reset_password_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/user_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/verify_otp_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> login(Login login);

  Future<Either<Failure, User>> verifyOTP(VerifyOTP verifyOTP);

  Future<Either<Failure, Unit>> register(Register register, Roll roll);

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> resendOTP(ResendOTP resendOTP);

  Future<Either<Failure, Unit>> resetPassword(ResetPassword resetPassword);

  Future<Either<Failure, Unit>> refreshToken();
}
