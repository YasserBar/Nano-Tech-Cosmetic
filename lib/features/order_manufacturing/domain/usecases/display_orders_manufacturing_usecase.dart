import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/entities/order_manufacturing_entity.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/repository/order_manufacturing_repo.dart';

class DisplayOrdersManufacturingUsecase {
  final OrderManufacturingRepo repo;

  DisplayOrdersManufacturingUsecase(this.repo);

  Future<Either<Failure, List<OrderManufacturing>>> call(
      {required int page, OrderStatus? orderStatus}) async {
    return await repo.displayOrdersManufacturing(
        page: page, orderStatus: orderStatus);
  }
}
