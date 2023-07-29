import 'package:dartz/dartz.dart';

import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/category/domain/entities/category_entity.dart';

abstract class CategoryRepo {
  Future<Either<Failure, List<Category>>> showAllCategory(int page);
}
