import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';

class LogoutUsecase {
  final AuthRepo repo;

  LogoutUsecase(this.repo);

  Future<Either<Failure, Unit>> call() async {
    return await repo.logout();
  }
}
