import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/login_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/user_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';

class LoginUsecase {
  final AuthRepo repo;

  LoginUsecase(this.repo);

  Future<Either<Failure, User>> call(Login login) async {
    return await repo.login(login);
  }
}
