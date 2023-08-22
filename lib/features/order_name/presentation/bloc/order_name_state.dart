import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_messages.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/entities/order_name_entity.dart';

abstract class OrderNameState extends Equatable {
  final List<OrderName>? ordersName;
  final bool hasMore;
  final bool loaded;
  final String message;
  const OrderNameState(this.ordersName, this.hasMore, this.loaded,
      {required this.message});

  @override
  List<Object> get props => [ordersName ?? [], hasMore, loaded, message];
}

class OrderNameInitial extends OrderNameState {
  const OrderNameInitial(super.ordersName, super.hasMore, super.loaded,
      {required super.message});
}

class LoadingOrderNameState extends OrderNameState {
  const LoadingOrderNameState(super.ordersName, super.hasMore, super.loaded,
      {required super.message});
}

class FailureOrderNameState extends OrderNameState {
  const FailureOrderNameState(super.ordersName, super.hasMore, super.loaded,
      {required super.message});
}

class InternalServerFailureOrderNameState extends OrderNameState {
  const InternalServerFailureOrderNameState(
      super.ordersName, super.hasMore, super.loaded,
      {super.message = AppMessages.internalServerError});
}

class UnexpectedFailureOrderNameState extends OrderNameState {
  const UnexpectedFailureOrderNameState(
      super.ordersName, super.hasMore, super.loaded,
      {super.message = AppMessages.unexpectedException});
}

class OfflineFailureOrderNameState extends OrderNameState {
  const OfflineFailureOrderNameState(super.ordersName, super.hasMore, super.loaded,
      {super.message = AppMessages.offline});
}

class LoadedOrdersNameState extends OrderNameState {
  const LoadedOrdersNameState(super.ordersName, super.hasMore, super.loaded,
      {required super.message});

  @override
  List<Object> get props => [ordersName!, hasMore, loaded, message];
}

class SuccessAddOrderNameState extends OrderNameState {
  const SuccessAddOrderNameState(super.ordersName, super.hasMore, super.loaded,
      {required super.message});
}
