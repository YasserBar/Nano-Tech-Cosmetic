import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/entities/rate_product_entity.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/repository/product_repo.dart';

class RateProductUsecase {
  final ProductRepo repo;

  RateProductUsecase(this.repo);

  Future<Either<Failure, Unit>> call(RateProduct rateProduct) async {
    return await repo.rateProduct(rateProduct);
  }
}
