import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/ad/domain/entities/ad_entity.dart';
import 'package:nano_tech_cosmetic/features/ad/domain/repository/ad_repo.dart';

class DisplayAdsUsecase {
  final AdRepo repo;

  DisplayAdsUsecase(this.repo);

  Future<Either<Failure, List<Ad>>> call(int page) async {
    return await repo.displayAds(page);
  }
}
