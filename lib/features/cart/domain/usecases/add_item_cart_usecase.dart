import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/repository/cart_repo.dart';

class AddItemCartUsecase {
  final CartRepo repo;

  AddItemCartUsecase(this.repo);

  Future<Either<Failure, Unit>> call(ItemCart itemCart) async {
    return await repo.addItemCart(itemCart);
  }
}
