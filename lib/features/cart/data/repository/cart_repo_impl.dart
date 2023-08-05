import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/core/helpers/network_info.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_exceptions.dart';
import 'package:nano_tech_cosmetic/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:nano_tech_cosmetic/features/cart/data/models/cart_model.dart';
import 'package:nano_tech_cosmetic/features/cart/data/models/item_cart_model.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/cart_entity.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/repository/cart_repo.dart';

class CartRepoImpl extends CartRepo {
  final CartLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CartRepoImpl({
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> addItemCart(ItemCart itemCart) async {
    ItemCartModel itemCartModel = ItemCartModel(
        id: itemCart.id,
        title: itemCart.title,
        price: itemCart.price,
        imageUrl: itemCart.imageUrl,
        account: itemCart.account);
    try {
      localDataSource.addItemCart(itemCartModel);
      return const Right(unit);
    } catch (e) {
      return Left(switchException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteItemCart(ItemCart itemCart) async {
    ItemCartModel itemCartModel = ItemCartModel(
        id: itemCart.id,
        title: itemCart.title,
        price: itemCart.price,
        imageUrl: itemCart.imageUrl,
        account: itemCart.account);
    try {
      localDataSource.deleteItemCart(itemCartModel);
      return const Right(unit);
    } catch (e) {
      return Left(switchException(e));
    }
  }

  @override
  Future<Either<Failure, Cart>> dispalyCart() async {
    try {
      CartModel cartModel = await localDataSource.dispalyCart();
      return Right(cartModel);
    } catch (e) {
      return Left(switchException(e));
    }
  }
}
