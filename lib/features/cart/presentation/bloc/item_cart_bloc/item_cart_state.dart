import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_messages.dart';

abstract class ItemCartState extends Equatable {
  final int? index;
  final String message;
  const ItemCartState({required this.index, required this.message});

  @override
  List<Object?> get props => [index, message];
}

class ItemCartInitial extends ItemCartState {
  const ItemCartInitial({required super.index, required super.message});
}

class LoadingItemCartState extends ItemCartState {
  const LoadingItemCartState({required super.index, required super.message});
}

class FailureItemCartState extends ItemCartState {
  const FailureItemCartState({required super.index, required super.message});
}

class EmptyCacheFailureItemCartState extends ItemCartState {
  const EmptyCacheFailureItemCartState(
      {required super.index, super.message = AppMessages.emptyCache});
}

class SuccessDeleteItemCartState extends ItemCartState {
  const SuccessDeleteItemCartState(
      {required super.index, super.message = AppMessages.deleteItemSuccessfully});
}

class SuccessIncreaseItemCartState extends ItemCartState {
  const SuccessIncreaseItemCartState(
      {required super.index, super.message = AppMessages.addItemSuccessfully});
}

class SuccessDecreaseItemCartState extends ItemCartState {
  const SuccessDecreaseItemCartState(
      {required super.index, super.message = AppMessages.addItemSuccessfully});
}
