// ignore: file_names
import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/user_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';

class VerifyOTPUsecase {
  final AuthRepo repo;

  VerifyOTPUsecase(this.repo);

  Future<Either<Failure, User>> call(VerifyOTP verifyOTP) async {
    return await repo.verifyOTP(verifyOTP);
  }
}
