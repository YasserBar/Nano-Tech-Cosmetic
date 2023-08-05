import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/cart_entity.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/repository/cart_repo.dart';

class DeleteItemCartUsecase {
  final CartRepo repo;

  DeleteItemCartUsecase(this.repo);

  Future<Either<Failure, Cart>> call(int index,int price) async {
    return await repo.deleteItemCart(index,price);
  }
}
