import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddItemCartEvent extends CartEvent {
  ItemCart itemCart;
  AddItemCartEvent({required this.itemCart});

  @override
  List<Object> get props => [itemCart];
}

class DisplayCartEvent extends CartEvent {
  const DisplayCartEvent();

  @override
  List<Object> get props => [];
}
