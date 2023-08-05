import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/add_item_cart_usecase.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/delete_item_cart.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/display_cart_usecase.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_event.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_state.dart';
import 'package:nano_tech_cosmetic/main.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final DisplayCartUsecase displayCartUsecase;
  final DeleteItemCartUsecase deleteItemCartUsecase;
  final AddItemCartUsecase addItemCartUsecase;

  CartBloc({
    required this.deleteItemCartUsecase,
    required this.addItemCartUsecase,
    required this.displayCartUsecase,
  }) : super(const CartInitial(null, message: 'init state')) {
    on<DisplayCartEvent>((event, emit) async {
      emit(const LoadingCartState(null, message: "loading"));
      final failureOrCart = await displayCartUsecase();
      failureOrCart.fold((failure) {
        emit(switchFailure(failure));
      }, (cart) {
        emit(LoadedCartState(cart, message: globalMessage!));
      });
    });
    on<DeleteItemCartEvent>((event, emit) async {
      emit(const LoadingCartState(null, message: "loading"));
      final failureOrDone = await deleteItemCartUsecase(event.itemCart);
      failureOrDone.fold((failure) {
        emit(switchFailure(failure));
      }, (cart) {
        emit(SuccessDeleteItemCartState(null, message: globalMessage!));
      });
    });
    on<AddItemCartEvent>((event, emit) async {
      emit(const LoadingCartState(null, message: "loading"));
      final failureOrCategories = await addItemCartUsecase(event.itemCart);
      failureOrCategories.fold((failure) {
        emit(switchFailure(failure));
      }, (cart) {
        emit(SuccessAddItemCartState(null, message: globalMessage!));
      });
    });
  }
}

CartState switchFailure(failure) {
  if (failure is EmptyCacheFailure) {
    return const EmptyCacheFailureCartState(null);
  }
  return FailureCartState(null, message: globalMessage ?? "No any message");
}
