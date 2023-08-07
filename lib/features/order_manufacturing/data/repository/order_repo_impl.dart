import 'package:dartz/dartz.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/core/helpers/network_info.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_exceptions.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';
import 'package:nano_tech_cosmetic/features/order/data/models/order_model.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/data/data_sources/order_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/data/models/request_order_manufacturing_model.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/entities/order_manufacturing_entity.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/entities/request_order_manufacturing_entity.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/repository/order_manufacturing_repo.dart';

class OrderManufacturingRepoImpl extends OrderManufacturingRepo {
  final OrderManufacturingRemoteDataSource remoteDataSource;
  final AuthRepo authRepo;
  final NetworkInfo networkInfo;

  OrderManufacturingRepoImpl({
    required this.remoteDataSource,
    required this.authRepo,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<OrderManufacturing>>> displayOrdersManufacturing(
      {required int page, OrderStatus? orderStatus}) async {
    int? status;
    if (orderStatus != null) {
      status = switchFromOrderStatus(orderStatus);
    }
    if (await networkInfo.isConnected) {
      try {
        final List<OrderManufacturing> ordersManufacturing =
            await remoteDataSource.displayOrdersManufacturing(
                page: page, status: status);
        return Right(ordersManufacturing);
      } on UnauthorizedException {
        final Either<Failure, Unit> either = await authRepo.refreshToken();
        return either.fold(
          (failure) => Left(failure),
          (unit) async {
            try {
              final List<OrderManufacturing> ordersManufacturing =
                  await remoteDataSource.displayOrdersManufacturing(
                      page: page, status: status);
              return Right(ordersManufacturing);
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
  Future<Either<Failure, Unit>> addOrderManufacturing(
      {required RequestOrderManufacturing requestOrderManufacturing}) async {
    final RequestOrderManufacturingModel requestOrderManufacturingModel =
        RequestOrderManufacturingModel(
      details: requestOrderManufacturing.details,
      productId: requestOrderManufacturing.productId,
      amount: requestOrderManufacturing.amount,
      note: requestOrderManufacturing.note,
    );

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addOrderManufacturing(
            requestOrderManufacturingModel: requestOrderManufacturingModel);
        return const Right(unit);
      } on UnauthorizedException {
        final Either<Failure, Unit> either = await authRepo.refreshToken();
        return either.fold(
          (failure) => Left(failure),
          (done) async {
            try {
              await remoteDataSource.addOrderManufacturing(
                  requestOrderManufacturingModel:
                      requestOrderManufacturingModel);
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
