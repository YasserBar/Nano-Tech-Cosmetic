import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/features/order/domain/entities/request_order_entity.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class DisplayOrderEvent extends OrderEvent {
  OrderStatus? orderStatus;
  DisplayOrderEvent({this.orderStatus});
}

class StoreOrderEvent extends OrderEvent {
  RequestOrder requestOrder;
  StoreOrderEvent({required this.requestOrder});

  @override
  List<Object> get props => [requestOrder];
}

class LoadMoreOrdersEvent extends OrderEvent {
  OrderStatus? orderStatus;
  LoadMoreOrdersEvent({this.orderStatus});
}

class DisplayOrderDetailsEvent extends OrderEvent {
  int orderId;
  DisplayOrderDetailsEvent({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class LoadMoreOrderDetailsEvent extends OrderEvent {
  int orderId;
  LoadMoreOrderDetailsEvent({required this.orderId});

  @override
  List<Object> get props => [orderId];
}
