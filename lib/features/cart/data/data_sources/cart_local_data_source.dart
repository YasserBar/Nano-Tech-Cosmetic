import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/constants/app_keys.dart';
import 'package:nano_tech_cosmetic/core/errors/exception.dart';
import 'package:nano_tech_cosmetic/features/cart/data/models/cart_model.dart';
import 'package:nano_tech_cosmetic/features/cart/data/models/item_cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartLocalDataSource {
  Future<Unit> deleteItemCart(ItemCartModel itemCartModel);
  Future<Unit> addItemCart(ItemCartModel itemCartModel);
  Future<CartModel> dispalyCart();
}

class CartLocalDataSourceImplWithHttp extends CartLocalDataSource {
  final SharedPreferences pref;

  CartLocalDataSourceImplWithHttp({required this.pref});
  @override
  Future<Unit> addItemCart(ItemCartModel itemCartModel) async {
    CartModel cartModel;
    try {
      cartModel = await dispalyCart();
      List<ItemCartModel> itemsCartModel =
          cartModel.itemsCart as List<ItemCartModel>;
      cartModel = CartModel(
          totalPrice: cartModel.totalPrice + itemCartModel.account,
          itemsCart: itemsCartModel..add(itemCartModel));
      await pref.setString(AppKeys.CACHED_ITEM_CART, json.encode(cartModel));
    } catch (e) {
      List<ItemCartModel> itemsCartModel = [itemCartModel];
      cartModel = CartModel(
          totalPrice: itemCartModel.account, itemsCart: itemsCartModel);
      await pref.setString(AppKeys.CACHED_ITEM_CART, json.encode(cartModel));
    }

    return Future.value(unit);
  }

  @override
  Future<CartModel> dispalyCart() {
    final String? cartString = pref.getString(AppKeys.CACHED_CART);
    if (cartString != null) {
      return Future.value(CartModel.fromJson(json.decode(cartString)));
    }
    throw EmptyCacheException();
  }

  @override
  Future<Unit> deleteItemCart(ItemCartModel itemCartModel) async {
    try {
      CartModel? cartModel = await dispalyCart();
      cartModel.itemsCart.removeWhere(
        (item) =>
            item.id == itemCartModel.id &&
            item.isProduct == itemCartModel.isProduct,
      );
      await pref.setString(AppKeys.CACHED_ITEM_CART, json.encode(cartModel));
      return Future.value(unit);
    } catch (e) {
      throw EmptyCacheException();
    }
  }
}
