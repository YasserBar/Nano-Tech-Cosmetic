import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/decrease_item_cart.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/delete_item_cart.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/increase_item_cart.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/item_cart_bloc/item_cart_event.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/item_cart_bloc/item_cart_state.dart';
import 'package:nano_tech_cosmetic/main.dart';

class ItemCartBloc extends Bloc<ItemCartEvent, ItemCartState> {
  final DeleteItemCartUsecase deleteItemCartUsecase;
  final DecreaseItemCartUsecase decreaseItemCartUsecase;
  final IncreaseItemCartUsecase increaseItemCartUsecase;

  ItemCartBloc({
    required this.deleteItemCartUsecase,
    required this.decreaseItemCartUsecase,
    required this.increaseItemCartUsecase,
  }) : super(const ItemCartInitial(index: null, message: 'init state')) {
    on<DeleteItemCartEvent>((event, emit) async {
      emit(const LoadingItemCartState(index: null, message: "loading"));
      final failureOrDone = await deleteItemCartUsecase(event.index);
      failureOrDone.fold((failure) {
        emit(switchFailure(failure, event.index));
      }, (done) {
        emit(SuccessDeleteItemCartState(index: event.index));
      });
    });
    on<DecreaseItemCartEvent>((event, emit) async {
      emit(const LoadingItemCartState(index: null, message: "loading"));
      final failureOrDone = await decreaseItemCartUsecase(event.index);
      failureOrDone.fold((failure) {
        emit(switchFailure(failure, event.index));
      }, (done) {
        emit(SuccessDecreaseItemCartState(index: event.index));
      });
    });
    on<IncreaseItemCartEvent>((event, emit) async {
      emit(const LoadingItemCartState(index: null, message: "loading"));
      final failureOrDone = await increaseItemCartUsecase(event.index);
      failureOrDone.fold((failure) {
        emit(switchFailure(failure, event.index));
      }, (done) {
        emit(SuccessIncreaseItemCartState(index: event.index));
      });
    });
  }
}

ItemCartState switchFailure(failure, int index) {
  if (failure is EmptyCacheFailure) {
    return EmptyCacheFailureItemCartState(
      index: index,
    );
  }
  return FailureItemCartState(
      index: index, message: globalMessage ?? "No any message");
}
