import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/entities/order_name_entity.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/repository/order_repo.dart';

class DisplayOrdersNameUsecase {
  final OrderNameRepo repo;

  DisplayOrdersNameUsecase(this.repo);

  Future<Either<Failure, List<OrderName>>> call(
      {required int page, OrderStatus? orderStatus}) async {
    return await repo.displayOrdersName(page: page, orderStatus: orderStatus);
  }
}
