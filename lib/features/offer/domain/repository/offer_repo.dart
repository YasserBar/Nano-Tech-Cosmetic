import 'package:dartz/dartz.dart';

import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/offer/domain/entities/offer_entity.dart';

abstract class OfferRepo {
  Future<Either<Failure, List<Offer>>> showOffers(int page, {int? productId});
}
