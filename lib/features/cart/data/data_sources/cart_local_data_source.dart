import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/constants/app_keys.dart';
import 'package:nano_tech_cosmetic/core/errors/exception.dart';
import 'package:nano_tech_cosmetic/features/cart/data/models/cart_model.dart';
import 'package:nano_tech_cosmetic/features/cart/data/models/item_cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartLocalDataSource {
  Future<CartModel> deleteItemCart(int index, int price);
  Future<Unit> addItemCart(ItemCartModel itemCartModel);
  Future<CartModel> dispalyCart();
}

class CartLocalDataSourceImplWithHttp extends CartLocalDataSource {
  final SharedPreferences pref;

  CartLocalDataSourceImplWithHttp({required this.pref});
  @override
  Future<Unit> addItemCart(ItemCartModel itemCartModel) async {
    CartModel cartModel;
    print("step 1  itemCartModel : $itemCartModel");
    try {
      cartModel = await dispalyCart();
      print("step 2  cartModel : $cartModel");

      List<ItemCartModel> itemsCartModel =
          cartModel.itemsCart as List<ItemCartModel>;
      print("step 3  itemsCartModel : $itemsCartModel");

      cartModel = CartModel(
          totalPrice: cartModel.totalPrice + itemCartModel.price,
          itemsCart: itemsCartModel..add(itemCartModel));
      print("step 4  cartModel : $cartModel");

      await pref.setString(AppKeys.CACHED_CART, json.encode(cartModel));
    } catch (e) {
      List<ItemCartModel> itemsCartModel = <ItemCartModel>[itemCartModel];
      print("step 5  itemsCartModel : $itemsCartModel");

      cartModel =
          CartModel(totalPrice: itemCartModel.price, itemsCart: itemsCartModel);
      print("step 6  cartModel : $cartModel");

      await pref.setString(AppKeys.CACHED_CART, json.encode(cartModel));
    }

    return Future.value(unit);
  }

  @override
  Future<CartModel> dispalyCart() {
    final String? cartString = pref.getString(AppKeys.CACHED_CART);
    print("step 7  cartString : $cartString");

    if (cartString != null) {
      return Future.value(CartModel.fromJson(json.decode(cartString)));
    }
    throw EmptyCacheException();
  }

  @override
  Future<CartModel> deleteItemCart(int index, int price) async {
    try {
      CartModel? cartModel = await dispalyCart();
      cartModel.itemsCart.removeAt(index);
      cartModel = CartModel(
          totalPrice: cartModel.totalPrice - price,
          itemsCart: cartModel.itemsCart as List<ItemCartModel>);
      await pref.setString(AppKeys.CACHED_CART, json.encode(cartModel));
      return Future.value(cartModel);
    } catch (e) {
      throw EmptyCacheException();
    }
  }
}
