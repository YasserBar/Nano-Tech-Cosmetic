import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/order/domain/repository/order_repo.dart';
import 'package:nano_tech_cosmetic/features/order/domain/entities/order_entity.dart'
    as order;

class DisplayOrdersUsecase {
  final OrderRepo repo;

  DisplayOrdersUsecase(this.repo);

  Future<Either<Failure, List<order.Order>>> call(
      {required int page, OrderStatus? orderStatus}) async {
    return await repo.displayOrders(page: page, orderStatus: orderStatus);
  }
}
