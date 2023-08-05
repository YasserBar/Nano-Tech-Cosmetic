import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class DeleteItemCartEvent extends CartEvent {
  int price;
  int index;
  DeleteItemCartEvent({required this.index, required this.price});

  @override
  List<Object> get props => [index];
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
