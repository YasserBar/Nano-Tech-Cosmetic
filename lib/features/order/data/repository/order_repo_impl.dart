import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/core/helpers/network_info.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_exceptions.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';
import 'package:nano_tech_cosmetic/features/order/data/data_sources/order_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/order/data/models/order_details_model.dart';
import 'package:nano_tech_cosmetic/features/order/data/models/order_model.dart';
import 'package:nano_tech_cosmetic/features/order/data/models/request_order_model.dart';
import 'package:nano_tech_cosmetic/features/order/domain/entities/request_order_entity.dart';
import 'package:nano_tech_cosmetic/features/order/domain/repository/order_repo.dart';
import 'package:nano_tech_cosmetic/features/order/domain/entities/order_entity.dart'
    as order;

class OrderRepoImpl extends OrderRepo {
  final OrderRemoteDataSource remoteDataSource;
  final AuthRepo authRepo;
  final NetworkInfo networkInfo;

  OrderRepoImpl({
    required this.remoteDataSource,
    required this.authRepo,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<order.Order>>> displayOrders(
      {required int page, OrderStatus? orderStatus}) async {
    int? status;
    if (orderStatus != null) {
      status = switchFromOrderStatus(orderStatus);
    }
    if (await networkInfo.isConnected) {
      try {
        final List<OrderModel> orders =
            await remoteDataSource.displayOrders(page: page, status: status);
        // if (kDebugMode) {
        //   print("step 2===== $orders");
        // }
        return Right(orders);
      } on UnauthorizedException {
        final Either<Failure, Unit> either = await authRepo.refreshToken();
        return either.fold(
          (failure) => Left(failure),
          (unit) async {
            try {
              final List<OrderModel> orders = await remoteDataSource
                  .displayOrders(page: page, status: status);
              return Right(orders);
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
  Future<Either<Failure, Unit>> storeOrder(
      {required RequestOrder requestOrder}) async {
    final RequestOrderModel requestOrderModel = RequestOrderModel(
        productIds: requestOrder.productIds,
        colorIds: requestOrder.colorIds,
        quantitiesProducts: requestOrder.quantitiesProducts,
        offerIds: requestOrder.offerIds,
        quantitiesOffers: requestOrder.quantitiesOffers);

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.storeOrder(requestOrderModel: requestOrderModel);
        return const Right(unit);
      } on UnauthorizedException {
        final Either<Failure, Unit> either = await authRepo.refreshToken();
        return either.fold(
          (failure) => Left(failure),
          (done) async {
            try {
              await remoteDataSource.storeOrder(
                  requestOrderModel: requestOrderModel);
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

  @override
  Future<Either<Failure, OrderDetailsModel>> displayOrderDetails(
      {required int page, required int orderId}) async {
    if (await networkInfo.isConnected) {
      try {
        final OrderDetailsModel orderDetailsModel = await remoteDataSource
            .displayOrderDetails(page: page, orderId: orderId);
        return Right(orderDetailsModel);
      } on UnauthorizedException {
        final Either<Failure, Unit> either = await authRepo.refreshToken();
        return either.fold(
          (failure) => Left(failure),
          (unit) async {
            try {
              final OrderDetailsModel orderDetailsModel = await remoteDataSource
                  .displayOrderDetails(page: page, orderId: orderId);
              return Right(orderDetailsModel);
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
