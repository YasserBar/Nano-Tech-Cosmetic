import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/reset_password_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';

class ResetPasswordUsecase {
  final AuthRepo repo;

  ResetPasswordUsecase(this.repo);

  Future<Either<Failure, Unit>> call(ResetPassword resetPassword) async {
    return await repo.resetPassword(resetPassword);
  }
}
