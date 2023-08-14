import 'package:equatable/equatable.dart';

abstract class ItemCartEvent extends Equatable {
  const ItemCartEvent();

  @override
  List<Object> get props => [];
}

class DeleteItemCartEvent extends ItemCartEvent {
  int index;
  DeleteItemCartEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class IncreaseItemCartEvent extends ItemCartEvent {
  int index;
  IncreaseItemCartEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class DecreaseItemCartEvent extends ItemCartEvent {
  int index;
  DecreaseItemCartEvent({required this.index});

  @override
  List<Object> get props => [index];
}
