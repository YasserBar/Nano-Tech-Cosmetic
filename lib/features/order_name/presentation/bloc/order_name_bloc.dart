import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/usecases/add_order_name_usecase.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/usecases/display_orders_name_usecase.dart';
import 'package:nano_tech_cosmetic/features/order_name/presentation/bloc/order_name_event.dart';
import 'package:nano_tech_cosmetic/features/order_name/presentation/bloc/order_name_state.dart';
import 'package:nano_tech_cosmetic/main.dart';

class OrderNameBloc extends Bloc<OrderNameEvent, OrderNameState> {
  final DisplayOrdersNameUsecase displayOrdersNameUsecase;
  final AddOrderNameUsecase addOrderNameUsecase;

  int page = 1;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  OrderStatus? orderStatus;
  int? orderId;

  OrderNameBloc({
    required this.displayOrdersNameUsecase,
    required this.addOrderNameUsecase,
  }) : super(const OrderNameInitial(null, true, true, message: 'init state')) {
    scrollController.addListener(() {
      if (!isLoadingMore) {
        add(LoadMoreOrdersNameEvent(orderStatus: orderStatus));
      }
    });
    on<AddOrderNameEvent>((event, emit) async {
      emit(const LoadingOrderNameState(null, true, true, message: "loading"));
      final failureOrDone =
          await addOrderNameUsecase(requestOrderName: event.requestOrderName);
      failureOrDone.fold((failure) {
        emit(switchFailure(failure));
      }, (done) {
        emit(SuccessAddOrderNameState(null, true, true,
            message: globalMessage!));
      });
    });
    on<DisplayOrdersNameEvent>((event, emit) async {
      emit(const LoadingOrderNameState(null, true, true, message: "loading"));
      page = 1;
      orderStatus=event.orderStatus;
      final failureOrOrders =
          await displayOrdersNameUsecase(page: page, orderStatus: event.orderStatus);
      failureOrOrders.fold((failure) {
        emit(switchFailure(failure));
      }, (ordersName) {
        emit(LoadedOrdersNameState(ordersName, true, true,
            message: globalMessage!));
      });
    });
    on<LoadMoreOrdersNameEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedOrdersNameState(state.ordersName, true, false,
            message: globalMessage!));
        page++;
        orderStatus=event.orderStatus;
        final failureOrOrders = await displayOrdersNameUsecase(
            page: page, orderStatus: event.orderStatus);
        failureOrOrders.fold((failure) {
          page--;
          emit(switchFailure(failure));
        }, (ordersName) {
          if (ordersName.isEmpty) {
            page--;
            emit(LoadedOrdersNameState(state.ordersName!, false, false,
                message: globalMessage!));
          } else {
            emit(LoadedOrdersNameState(
                [...state.ordersName!, ...ordersName], true, true,
                message: globalMessage!));
          }
        });
      }
      isLoadingMore = false;
    });
  }
}

OrderNameState switchFailure(failure) {
  if (failure is OfflineFailure) {
    return const OfflineFailureOrderNameState(null, true, true);
  } else if (failure is InternalServerErrorFailure) {
    return const InternalServerFailureOrderNameState(null, true, true);
  } else if (failure is UnexpectedFailure) {
    return const UnexpectedFailureOrderNameState(null, true, true);
  }
  return FailureOrderNameState(null, true, true,
      message: globalMessage ?? "No any message");
}
