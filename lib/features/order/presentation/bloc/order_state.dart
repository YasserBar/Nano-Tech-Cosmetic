import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_messages.dart';
import 'package:nano_tech_cosmetic/features/offer/domain/entities/offer_entity.dart';
import 'package:nano_tech_cosmetic/features/order/domain/entities/order_entity.dart'
    as o;
import 'package:nano_tech_cosmetic/features/prodect/domain/entities/product_entity.dart';

abstract class OrderState extends Equatable {
  final List<o.Order>? orders;
  final List<Offer>? orderOffers;
  final List<Product>? orderProducts;
  final bool hasMore;
  final bool loaded;
  final String message;
  const OrderState(this.orderProducts, this.orderOffers, this.orders,
      this.hasMore, this.loaded,
      {required this.message});

  @override
  List<Object> get props => [
        orderProducts ?? [],
        orderOffers ?? [],
        orders ?? [],
        hasMore,
        loaded,
        message
      ];
}

class OrderInitial extends OrderState {
  const OrderInitial(super.orderProducts, super.orderOffers, super.orders,
      super.hasMore, super.loaded,
      {required super.message});
}

class LoadingOrderState extends OrderState {
  const LoadingOrderState(super.orderProducts, super.orderOffers, super.orders,
      super.hasMore, super.loaded,
      {required super.message});
}

class FailureOrderState extends OrderState {
  const FailureOrderState(super.orderProducts, super.orderOffers, super.orders,
      super.hasMore, super.loaded,
      {required super.message});
}

class InternalServerFailureOrderState extends OrderState {
  const InternalServerFailureOrderState(super.orderProducts, super.orderOffers,
      super.orders, super.hasMore, super.loaded,
      {super.message = AppMessages.internalServerError});
}

class UnexpectedFailureOrderState extends OrderState {
  const UnexpectedFailureOrderState(super.orderProducts, super.orderOffers,
      super.orders, super.hasMore, super.loaded,
      {super.message = AppMessages.unexpectedException});
}

class OfflineFailureOrderState extends OrderState {
  const OfflineFailureOrderState(super.orderProducts, super.orderOffers,
      super.orders, super.hasMore, super.loaded,
      {super.message = AppMessages.offline});
}

class LoadedOrdersState extends OrderState {
  const LoadedOrdersState(super.orderProducts, super.orderOffers, super.orders,
      super.hasMore, super.loaded,
      {required super.message});

  @override
  List<Object> get props => [orders!, hasMore, loaded, message];
}

class LoadedOrderDetailsState extends OrderState {
  const LoadedOrderDetailsState(super.orderProducts, super.orderOffers,
      super.orders, super.hasMore, super.loaded,
      {required super.message});

  @override
  List<Object> get props =>
      [orderProducts!, orderOffers!, hasMore, loaded, message];
}

class SuccessStoreOrderState extends OrderState {
  const SuccessStoreOrderState(super.orderProducts, super.orderOffers,
      super.orders, super.hasMore, super.loaded,
      {required super.message});
}
