import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/entities/product_entity.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/repository/product_repo.dart';

class ShowAllProductUsecase {
  final ProductRepo repo;

  ShowAllProductUsecase(this.repo);

  Future<Either<Failure, List<Product>>> call(int page,
      {int? categoryId, String? name}) async {
    return await repo.showAllProduct(page, categoryId: categoryId, name: name);
  }
}
