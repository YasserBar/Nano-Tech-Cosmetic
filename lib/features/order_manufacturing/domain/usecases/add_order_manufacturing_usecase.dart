import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/entities/request_order_manufacturing_entity.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/repository/order_manufacturing_repo.dart';

class AddOrderManufacturingUsecase {
  final OrderManufacturingRepo repo;

  AddOrderManufacturingUsecase(this.repo);

  Future<Either<Failure, Unit>> call(
      {required RequestOrderManufacturing requestOrderManufacturing}) async {
    return await repo.addOrderManufacturing(
        requestOrderManufacturing: requestOrderManufacturing);
  }
}
