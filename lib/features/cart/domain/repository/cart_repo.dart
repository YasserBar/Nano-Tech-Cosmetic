
import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/cart_entity.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';

abstract class CartRepo {
  Future<Either<Failure, Unit>> deleteItemCart(int index);
  Future<Either<Failure, Unit>> increaseItemCart(int index);
  Future<Either<Failure, Unit>> decreaseItemCart(int index);
  Future<Either<Failure, Unit>> deleteCart();
  Future<Either<Failure, Unit>> addItemCart(ItemCart itemCart);
  Future<Either<Failure, Cart>> dispalyCart();
}
