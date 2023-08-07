import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';

import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/order/domain/entities/order_details_entity.dart';
import 'package:nano_tech_cosmetic/features/order/domain/entities/request_order_entity.dart';
import 'package:nano_tech_cosmetic/features/order/domain/entities/order_entity.dart'
    as order;

abstract class OrderRepo {
  Future<Either<Failure, List<order.Order>>> displayOrders(
      {required int page, OrderStatus? orderStatus});
  Future<Either<Failure, OrderDetails>> displayOrderDetails(
      {required int page, required int orderId});
  Future<Either<Failure, Unit>> storeOrder(
      {required RequestOrder requestOrder});
}
