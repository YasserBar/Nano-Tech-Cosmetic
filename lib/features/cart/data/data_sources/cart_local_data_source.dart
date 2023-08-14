import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nano_tech_cosmetic/core/constants/app_keys.dart';
import 'package:nano_tech_cosmetic/core/errors/exception.dart';
import 'package:nano_tech_cosmetic/features/cart/data/models/cart_model.dart';
import 'package:nano_tech_cosmetic/features/cart/data/models/item_cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartLocalDataSource {
  Future<CartModel> deleteItemCart(int index);
  Future<Unit> deleteCart();
  Future<CartModel> increaseItemCart(int index);
  Future<CartModel> decreaseItemCart(int index);
  Future<Unit> addItemCart(ItemCartModel itemCartModel);
  Future<CartModel> dispalyCart();
}

class CartLocalDataSourceImplWithHttp extends CartLocalDataSource {
  final SharedPreferences pref;

  CartLocalDataSourceImplWithHttp({required this.pref});
  @override
  Future<Unit> addItemCart(ItemCartModel itemCartModel) async {
    CartModel cartModel;
    if (kDebugMode) {
      print("step 1  itemCartModel : $itemCartModel");
    }
    try {
      cartModel = await dispalyCart();
      if (kDebugMode) {
        print("step 2  cartModel : $cartModel");
      }

      List<ItemCartModel> itemsCartModel =
          cartModel.itemsCart as List<ItemCartModel>;
      if (kDebugMode) {
        print("step 3  itemsCartModel : $itemsCartModel");
      }

      cartModel = CartModel(
          totalPrice: cartModel.totalPrice + itemCartModel.price,
          itemsCart: itemsCartModel..add(itemCartModel));

      await pref.setString(AppKeys.CACHED_CART, json.encode(cartModel));
    } catch (e) {
      List<ItemCartModel> itemsCartModel = <ItemCartModel>[itemCartModel];
      if (kDebugMode) {
        print("step 5  itemsCartModel : $itemsCartModel");
      }

      cartModel =
          CartModel(totalPrice: itemCartModel.price, itemsCart: itemsCartModel);
      if (kDebugMode) {
        print("step 6  cartModel : $cartModel");
      }

      await pref.setString(AppKeys.CACHED_CART, json.encode(cartModel));
    }

    return Future.value(unit);
  }

  @override
  Future<CartModel> dispalyCart() {
    final String? cartString = pref.getString(AppKeys.CACHED_CART);
    if (kDebugMode) {
      print("step 7  cartString : $cartString");
    }

    if (cartString != null) {
      return Future.value(CartModel.fromJson(json.decode(cartString)));
    }
    throw EmptyCacheException();
  }

  @override
  Future<CartModel> deleteItemCart(int index) async {
    try {
      CartModel? cartModel = await dispalyCart();
      cartModel.totalPrice -= (cartModel.itemsCart[index].price *
          cartModel.itemsCart[index].account);
      cartModel.itemsCart.removeAt(index);
      cartModel = CartModel(
          totalPrice: cartModel.totalPrice,
          itemsCart: cartModel.itemsCart as List<ItemCartModel>);
      await pref.setString(AppKeys.CACHED_CART, json.encode(cartModel));
      return Future.value(cartModel);
    } catch (e) {
      throw EmptyCacheException();
    }
  }

  @override
  Future<CartModel> decreaseItemCart(int index) async {
    try {
      CartModel? cartModel = await dispalyCart();
      if (cartModel.itemsCart[index].account > 1) {
        cartModel.itemsCart[index].account -= 1;
        cartModel.totalPrice -= cartModel.itemsCart[index].price;
      }
      cartModel = CartModel(
          totalPrice: cartModel.totalPrice,
          itemsCart: cartModel.itemsCart as List<ItemCartModel>);
      await pref.setString(AppKeys.CACHED_CART, json.encode(cartModel));
      return Future.value(cartModel);
    } catch (e) {
      throw EmptyCacheException();
    }
  }

  @override
  Future<CartModel> increaseItemCart(int index) async {
    try {
      CartModel? cartModel = await dispalyCart();
      cartModel.itemsCart[index].account += 1;
      cartModel.totalPrice += cartModel.itemsCart[index].price;
      cartModel = CartModel(
          totalPrice: cartModel.totalPrice,
          itemsCart: cartModel.itemsCart as List<ItemCartModel>);
      await pref.setString(AppKeys.CACHED_CART, json.encode(cartModel));
      return Future.value(cartModel);
    } catch (e) {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> deleteCart() async {
    try {
      await pref.remove(AppKeys.CACHED_CART);
      return Future.value(unit);
    } catch (e) {
      throw EmptyCacheException();
    }
  }
}
