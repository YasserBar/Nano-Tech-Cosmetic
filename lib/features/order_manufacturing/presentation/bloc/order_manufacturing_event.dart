import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/entities/request_order_manufacturing_entity.dart';

abstract class OrderManufacturingEvent extends Equatable {
  const OrderManufacturingEvent();

  @override
  List<Object> get props => [];
}

class DisplayOrdersManufacturingEvent extends OrderManufacturingEvent {
  OrderStatus? orderStatus;
  DisplayOrdersManufacturingEvent({this.orderStatus});
}

class AddOrderManufacturingEvent extends OrderManufacturingEvent {
  RequestOrderManufacturing requestOrderManufacturing;
  AddOrderManufacturingEvent({required this.requestOrderManufacturing});

  @override
  List<Object> get props => [requestOrderManufacturing];
}

class LoadMoreOrdersManufacturingEvent extends OrderManufacturingEvent {
  OrderStatus? orderStatus;
  LoadMoreOrdersManufacturingEvent({this.orderStatus});
}
