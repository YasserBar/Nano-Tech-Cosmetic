import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/cart_entity.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/repository/cart_repo.dart';

class DisplayCartUsecase {
  final CartRepo repo;

  DisplayCartUsecase(this.repo);

  Future<Either<Failure, Cart>> call(int page) async {
    return await repo.dispalyCart();
  }
}
