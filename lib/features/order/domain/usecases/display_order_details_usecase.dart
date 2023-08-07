import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/order/domain/entities/order_details_entity.dart';
import 'package:nano_tech_cosmetic/features/order/domain/repository/order_repo.dart';

class DisplayOrderDetailsUsecase {
  final OrderRepo repo;

  DisplayOrderDetailsUsecase(this.repo);

  Future<Either<Failure, OrderDetails>> call(
      {required int page, required int orderId}) async {
    return await repo.displayOrderDetails(page: page, orderId: orderId);
  }
}
