import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/entities/request_order_name_entity.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/repository/order_repo.dart';

class AddOrderNameUsecase {
  final OrderNameRepo repo;

  AddOrderNameUsecase(this.repo);

  Future<Either<Failure, Unit>> call(
      {required RequestOrderName requestOrderName}) async {
    return await repo.addOrderName(requestOrderName: requestOrderName);
  }
}
