import 'package:dartz/dartz.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/core/helpers/network_info.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_exceptions.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';
import 'package:nano_tech_cosmetic/features/order/data/models/order_model.dart';
import 'package:nano_tech_cosmetic/features/order_name/data/data_sources/order_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/order_name/data/models/order_model.dart';
import 'package:nano_tech_cosmetic/features/order_name/data/models/request_order_name_model.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/entities/order_name_entity.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/entities/request_order_name_entity.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/repository/order_repo.dart';

class OrderNameRepoImpl extends OrderNameRepo {
  final OrderNameRemoteDataSource remoteDataSource;
  final AuthRepo authRepo;
  final NetworkInfo networkInfo;

  OrderNameRepoImpl({
    required this.remoteDataSource,
    required this.authRepo,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<OrderName>>> displayOrdersName(
      {required int page, OrderStatus? orderStatus}) async {
    int? status;
    if (orderStatus != null) {
      status = switchFromOrderStatus(orderStatus);
    }
    if (await networkInfo.isConnected) {
      try {
        final List<OrderNameModel> ordersName = await remoteDataSource
            .displayOrdersName(page: page, status: status);
        return Right(ordersName);
      } on UnauthorizedException {
        final Either<Failure, Unit> either = await authRepo.refreshToken();
        return either.fold(
          (failure) => Left(failure),
          (unit) async {
            try {
              final List<OrderNameModel> ordersName = await remoteDataSource
                  .displayOrdersName(page: page, status: status);
              return Right(ordersName);
            } on UnauthorizedException {
              return Left(UnauthorizedFailure());
            } catch (e) {
              return Left(switchException(e));
            }
          },
        );
      } catch (e) {
        return Left(switchException(e));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addOrderName(
      {required RequestOrderName requestOrderName}) async {
    final RequestOrderNameModel requestOrderNameModel = RequestOrderNameModel(
      newName: requestOrderName.newName,
      productId: requestOrderName.productId,
      amount: requestOrderName.amount,
      note: requestOrderName.note,
    );

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addOrderName(
            requestOrderNameModel: requestOrderNameModel);
        return const Right(unit);
      } on UnauthorizedException {
        final Either<Failure, Unit> either = await authRepo.refreshToken();
        return either.fold(
          (failure) => Left(failure),
          (done) async {
            try {
              await remoteDataSource.addOrderName(
                  requestOrderNameModel: requestOrderNameModel);
              return const Right(unit);
            } on UnauthorizedException {
              return Left(UnauthorizedFailure());
            } catch (e) {
              return Left(switchException(e));
            }
          },
        );
      } catch (e) {
        return Left(switchException(e));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
