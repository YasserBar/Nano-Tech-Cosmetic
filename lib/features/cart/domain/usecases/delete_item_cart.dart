import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/repository/cart_repo.dart';

class DeleteItemCartUsecase {
  final CartRepo repo;

  DeleteItemCartUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int index) async {
    return await repo.deleteItemCart(index);
  }
}
