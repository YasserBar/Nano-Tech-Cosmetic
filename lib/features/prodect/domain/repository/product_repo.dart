import 'package:dartz/dartz.dart';

import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/entities/product_entity.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<Product>>> showAllProduct(int page,
      {int? categoryId, String? name});
  Future<Either<Failure, Unit>> rateProduct(int rate, int prodectId);
}
