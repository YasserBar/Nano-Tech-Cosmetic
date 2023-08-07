import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/category/domain/entities/category_entity.dart';
import 'package:nano_tech_cosmetic/features/category/domain/repository/category_repo.dart';

class ShowAllCategoryUsecase {
  final CategoryRepo repo;

  ShowAllCategoryUsecase(this.repo);

  Future<Either<Failure, List<Category>>> call(int page, {String? name}) async {
    return await repo.showAllCategory(page, name: name);
  }
}
