import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/usecases/add_order_manufacturing_usecase.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/usecases/display_orders_manufacturing_usecase.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/presentation/bloc/order_manufacturing_event.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/presentation/bloc/order_manufacturing_state.dart';
import 'package:nano_tech_cosmetic/main.dart';

class OrderManufacturingBloc
    extends Bloc<OrderManufacturingEvent, OrderManufacturingState> {
  final DisplayOrdersManufacturingUsecase displayOrdersManufacturingUsecase;
  final AddOrderManufacturingUsecase addOrderManufacturingUsecase;

  int page = 1;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  OrderStatus? orderStatus;
  int? orderId;

  OrderManufacturingBloc({
    required this.displayOrdersManufacturingUsecase,
    required this.addOrderManufacturingUsecase,
  }) : super(const OrderManufacturingInitial(null, true, true,
            message: 'init state')) {
    scrollController.addListener(() {
      if (!isLoadingMore) {
        add(LoadMoreOrdersManufacturingEvent(orderStatus: orderStatus));
      }
    });
    on<AddOrderManufacturingEvent>((event, emit) async {
      emit(const LoadingOrderManufacturingState(null, true, true,
          message: "loading"));
      final failureOrDone = await addOrderManufacturingUsecase(
          requestOrderManufacturing: event.requestOrderManufacturing);
      failureOrDone.fold((failure) {
        emit(switchFailure(failure));
      }, (done) {
        emit(SuccessAddOrderManufacturingState(null, true, true,
            message: globalMessage!));
      });
    });
    on<DisplayOrdersManufacturingEvent>((event, emit) async {
      emit(const LoadingOrderManufacturingState(null, true, true,
          message: "loading"));
      final failureOrOrders = await displayOrdersManufacturingUsecase(
          page: page, orderStatus: orderStatus);
      failureOrOrders.fold((failure) {
        emit(switchFailure(failure));
      }, (ordersManufacturing) {
        emit(LoadedOrdersManufacturingState(ordersManufacturing, true, true,
            message: globalMessage!));
      });
    });
    on<LoadMoreOrdersManufacturingEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedOrdersManufacturingState(
            state.ordersManufacturing, true, false,
            message: globalMessage!));
        page++;
        final failureOrOrders = await displayOrdersManufacturingUsecase(
            page: page, orderStatus: orderStatus);
        failureOrOrders.fold((failure) {
          page--;
          emit(switchFailure(failure));
        }, (ordersManufacturing) {
          if (ordersManufacturing.isEmpty) {
            page--;
            emit(LoadedOrdersManufacturingState(
                state.ordersManufacturing!, false, false,
                message: globalMessage!));
          } else {
            emit(LoadedOrdersManufacturingState([
              ...state.ordersManufacturing!,
              ...ordersManufacturing
            ], true, true, message: globalMessage!));
          }
        });
      }
      isLoadingMore = false;
    });
  }
}

OrderManufacturingState switchFailure(failure) {
  if (failure is OfflineFailure) {
    return const OfflineFailureOrderManufacturingState(null, true, true);
  } else if (failure is InternalServerErrorFailure) {
    return const InternalServerFailureOrderManufacturingState(null, true, true);
  } else if (failure is UnexpectedFailure) {
    return const UnexpectedFailureOrderManufacturingState(null, true, true);
  }
  return FailureOrderManufacturingState(null, true, true,
      message: globalMessage ?? "No any message");
}
