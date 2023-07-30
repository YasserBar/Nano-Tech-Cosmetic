import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/repository/product_repo.dart';

class RateProductUsecase {
  final ProductRepo repo;

  RateProductUsecase(this.repo);

  Future<Either<Failure, Unit>> call(int rate, int prodectId) async {
    return await repo.rateProduct(rate, prodectId);
  }
}
