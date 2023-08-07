import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';

import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/entities/order_name_entity.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/entities/request_order_name_entity.dart';

abstract class OrderNameRepo {
  Future<Either<Failure, List<OrderName>>> displayOrdersName(
      {required int page, OrderStatus? orderStatus});
  Future<Either<Failure, Unit>> addOrderName(
      {required RequestOrderName requestOrderName});
}
