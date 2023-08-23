import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/order/domain/usecases/display_order_details_usecase.dart';
import 'package:nano_tech_cosmetic/features/order/domain/usecases/display_orders_usecase.dart';
import 'package:nano_tech_cosmetic/features/order/domain/usecases/store_order_usecase.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/bloc/order_event.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/bloc/order_state.dart';
import 'package:nano_tech_cosmetic/main.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final DisplayOrdersUsecase displayOrdersUsecase;
  final DisplayOrderDetailsUsecase displayOrderDetailsUsecase;
  final StoreOrderUsecase storeOrderUsecase;

  int page = 1;
  int pageOrderDetails = 1;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  OrderStatus? orderStatus;
  int? orderId;

  OrderBloc(
      {required this.displayOrdersUsecase,
      required this.storeOrderUsecase,
      required this.displayOrderDetailsUsecase})
      : super(const OrderInitial(null, null, null, true, true,
            message: 'init state')) {
    scrollController.addListener(() {
      if (!isLoadingMore) add(LoadMoreOrdersEvent(orderStatus: orderStatus));
    });
    on<StoreOrderEvent>((event, emit) async {
      emit(const LoadingOrderState(null, null, null, true, true,
          message: "loading"));
      final failureOrDone =
          await storeOrderUsecase(requestOrder: event.requestOrder);
      failureOrDone.fold((failure) {
        emit(switchFailure(failure));
      }, (done) {
        emit(SuccessStoreOrderState(null, null, null, true, true,
            message: globalMessage!));
      });
    });
    on<DisplayOrderEvent>((event, emit) async {
      emit(const LoadingOrderState(null, null, null, true, true,
          message: "loading"));
      final failureOrOrders =
          await displayOrdersUsecase(page: page, orderStatus: event.orderStatus);
      failureOrOrders.fold((failure) {
        emit(switchFailure(failure));
      }, (orders) {
        emit(LoadedOrdersState(null, null, orders, true, true,
            message: globalMessage!));
      });
    });
    on<LoadMoreOrdersEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedOrdersState(null, null, state.orders, true, false,
            message: globalMessage!));
        page++;
        final failureOrOrders =
            await displayOrdersUsecase(page: page, orderStatus: orderStatus);
        failureOrOrders.fold((failure) {
          page--;
          emit(switchFailure(failure));
        }, (orders) {
          if (orders.isEmpty) {
            page--;
            emit(LoadedOrdersState(null, null, state.orders!, false, false,
                message: globalMessage!));
          } else {
            emit(LoadedOrdersState(
                null, null, [...state.orders!, ...orders], true, true,
                message: globalMessage!));
          }
        });
      }
      isLoadingMore = false;
    });
    on<DisplayOrderDetailsEvent>((event, emit) async {
      emit(const LoadingOrderState(null, null, null, true, true,
          message: "loading"));
      final failureOrOrderDetails = await displayOrderDetailsUsecase(
          page: pageOrderDetails, orderId: event.orderId);
      failureOrOrderDetails.fold((failure) {
        emit(switchFailure(failure));
      }, (orderDetails) {
        emit(LoadedOrdersState(
            orderDetails.products, orderDetails.offers, null, true, true,
            message: globalMessage!));
      });
    });
    on<LoadMoreOrderDetailsEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedOrdersState(
            state.orderProducts, state.orderOffers, null, true, true,
            message: globalMessage!));
        page++;
        final failureOrOrderDetails = await displayOrderDetailsUsecase(
            page: pageOrderDetails, orderId: orderId!);
        failureOrOrderDetails.fold((failure) {
          page--;
          emit(switchFailure(failure));
        }, (orderDetails) {
          if (orderDetails.products.isEmpty && orderDetails.offers.isEmpty) {
            page--;
            emit(LoadedOrdersState(
                state.orderProducts!, state.orderOffers!, null, false, false,
                message: globalMessage!));
          } else if (orderDetails.products.isEmpty) {
            emit(LoadedOrdersState(
                state.orderProducts!,
                [...state.orderOffers!, ...orderDetails.offers],
                null,
                false,
                false,
                message: globalMessage!));
          } else if (orderDetails.offers.isEmpty) {
            emit(LoadedOrdersState(
                [...state.orderProducts!, ...orderDetails.products],
                state.orderOffers!,
                null,
                false,
                false,
                message: globalMessage!));
          } else {
            emit(LoadedOrdersState([
              ...state.orderProducts!,
              ...orderDetails.products
            ], [
              ...state.orderOffers!,
              ...orderDetails.offers
            ], null, true, true, message: globalMessage!));
          }
        });
      }
      isLoadingMore = false;
    });
  }
}

OrderState switchFailure(failure) {
  if (failure is OfflineFailure) {
    return const OfflineFailureOrderState(null, null, null, true, true);
  } else if (failure is InternalServerErrorFailure) {
    return const InternalServerFailureOrderState(null, null, null, true, true);
  } else if (failure is UnexpectedFailure) {
    return const UnexpectedFailureOrderState(null, null, null, true, true);
  }
  return FailureOrderState(null, null, null, true, true,
      message: globalMessage ?? "No any message");
}
