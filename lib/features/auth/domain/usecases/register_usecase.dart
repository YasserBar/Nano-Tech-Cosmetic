import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/constants/enum_roll.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/register_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';

class RegisterUsecase {
  final AuthRepo repo;

  RegisterUsecase(this.repo);

  Future<Either<Failure, Unit>> call(Register register, Roll roll) async {
    return await repo.register(register, roll);
  }
}
