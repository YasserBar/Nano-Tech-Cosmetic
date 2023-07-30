import 'package:dartz/dartz.dart';

import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/ad/domain/entities/ad_entity.dart';

abstract class AdRepo {
  Future<Either<Failure, List<Ad>>> displayAds(int page);
}
