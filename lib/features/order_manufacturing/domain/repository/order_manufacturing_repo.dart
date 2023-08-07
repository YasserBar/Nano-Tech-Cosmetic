import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';

import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/entities/order_manufacturing_entity.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/entities/request_order_manufacturing_entity.dart';

abstract class OrderManufacturingRepo {
  Future<Either<Failure, List<OrderManufacturing>>> displayOrdersManufacturing(
      {required int page, OrderStatus? orderStatus});
  Future<Either<Failure, Unit>> addOrderManufacturing(
      {required RequestOrderManufacturing requestOrderManufacturing});
}
