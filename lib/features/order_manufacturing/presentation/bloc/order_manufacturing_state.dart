import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_messages.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/entities/order_manufacturing_entity.dart';

abstract class OrderManufacturingState extends Equatable {
  final List<OrderManufacturing>? ordersManufacturing;
  final bool hasMore;
  final bool loaded;
  final String message;
  const OrderManufacturingState(
      this.ordersManufacturing, this.hasMore, this.loaded,
      {required this.message});

  @override
  List<Object> get props =>
      [ordersManufacturing ?? [], hasMore, loaded, message];
}

class OrderManufacturingInitial extends OrderManufacturingState {
  const OrderManufacturingInitial(
      super.ordersManufacturing, super.hasMore, super.loaded,
      {required super.message});
}

class LoadingOrderManufacturingState extends OrderManufacturingState {
  const LoadingOrderManufacturingState(
      super.ordersManufacturing, super.hasMore, super.loaded,
      {required super.message});
}

class FailureOrderManufacturingState extends OrderManufacturingState {
  const FailureOrderManufacturingState(
      super.ordersManufacturing, super.hasMore, super.loaded,
      {required super.message});
}

class InternalServerFailureOrderManufacturingState
    extends OrderManufacturingState {
  const InternalServerFailureOrderManufacturingState(
      super.ordersManufacturing, super.hasMore, super.loaded,
      {super.message = AppMessages.InternalServerError});
}

class UnexpectedFailureOrderManufacturingState extends OrderManufacturingState {
  const UnexpectedFailureOrderManufacturingState(
      super.ordersManufacturing, super.hasMore, super.loaded,
      {super.message = AppMessages.UnexpectedException});
}

class OfflineFailureOrderManufacturingState extends OrderManufacturingState {
  const OfflineFailureOrderManufacturingState(
      super.ordersManufacturing, super.hasMore, super.loaded,
      {super.message = AppMessages.Offline});
}

class LoadedOrdersManufacturingState extends OrderManufacturingState {
  const LoadedOrdersManufacturingState(
      super.ordersManufacturing, super.hasMore, super.loaded,
      {required super.message});

  @override
  List<Object> get props => [ordersManufacturing!, hasMore, loaded, message];
}

class SuccessAddOrderManufacturingState extends OrderManufacturingState {
  const SuccessAddOrderManufacturingState(
      super.ordersManufacturing, super.hasMore, super.loaded,
      {required super.message});
}
