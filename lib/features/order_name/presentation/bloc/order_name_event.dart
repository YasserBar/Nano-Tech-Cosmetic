import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/entities/request_order_name_entity.dart';

abstract class OrderNameEvent extends Equatable {
  const OrderNameEvent();

  @override
  List<Object> get props => [];
}

class DisplayOrdersNameEvent extends OrderNameEvent {
  OrderStatus? orderStatus;
  DisplayOrdersNameEvent({this.orderStatus});
}

class AddOrderNameEvent extends OrderNameEvent {
  RequestOrderName requestOrderName;
  AddOrderNameEvent({required this.requestOrderName});

  @override
  List<Object> get props => [requestOrderName];
}

class LoadMoreOrdersNameEvent extends OrderNameEvent {
  OrderStatus? orderStatus;
  LoadMoreOrdersNameEvent({this.orderStatus});
}
