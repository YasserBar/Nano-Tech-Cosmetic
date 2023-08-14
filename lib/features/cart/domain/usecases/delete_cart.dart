import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/repository/cart_repo.dart';

class DeleteCartUsecase {
  final CartRepo repo;

  DeleteCartUsecase(this.repo);

  Future<Either<Failure, Unit>> call() async {
    return await repo.deleteCart();
  }
}
