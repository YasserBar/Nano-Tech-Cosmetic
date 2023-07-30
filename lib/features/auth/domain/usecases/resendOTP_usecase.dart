import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/resend_otp_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';

class ResendOTPUsecase {
  final AuthRepo repo;

  ResendOTPUsecase(this.repo);

  Future<Either<Failure, Unit>> call(ResendOTP resendOTP) async {
    return await repo.resendOTP(resendOTP);
  }
}
