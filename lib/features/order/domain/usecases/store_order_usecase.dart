import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/order/domain/entities/request_order_entity.dart';
import 'package:nano_tech_cosmetic/features/order/domain/repository/order_repo.dart';

class StoreOrderUsecase {
  final OrderRepo repo;

  StoreOrderUsecase(this.repo);

  Future<Either<Failure, Unit>> call(
      {required RequestOrder requestOrder}) async {
    return await repo.storeOrder(requestOrder: requestOrder);
  }
}
