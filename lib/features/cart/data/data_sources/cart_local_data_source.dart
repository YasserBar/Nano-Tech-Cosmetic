// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:nano_tech_cosmetic/core/constants/app_keys.dart';
// import 'package:nano_tech_cosmetic/core/errors/exception.dart';
// import 'package:nano_tech_cosmetic/features/cart/data/models/cart_model.dart';
// import 'package:nano_tech_cosmetic/features/cart/data/models/item_cart_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// abstract class CartLocalDataSource {
//   Future<Unit> deleteItemCart(ItemCartModel itemCartModel);
//   Future<Unit> addItemCart(ItemCartModel itemCartModel);
//   Future<CartModel> dispalyCart();
// }

// class CartLocalDataSourceImplWithHttp extends CartLocalDataSource {
//   final SharedPreferences pref;

//   CartLocalDataSourceImplWithHttp({required this.pref});
//   @override
//   Future<Unit> addItemCart(ItemCartModel itemCartModel) async {
//     Object itemCartJson = itemCartModel.toJson();

//     await pref.setString(AppKeys.CACHED_ITEM_CART, jsonEncode(itemCartJson));

//     return Future.value(unit);
//   }

//   @override
//   Future<CartModel> dispalyCart() {
//     final String? cartString = pref.getString(AppKeys.CACHED_CART);
//     if (cartString != null) {
//       return Future.value(CartModel.fromJson(json.decode(cartString)));
//     }
//     throw EmptyCacheException();
//   }

//   @override
//   Future<Unit> deleteItemCart(ItemCartModel itemCartModel) async {
//     CartModel cartModel = await dispalyCart();
//     List<ItemCartModel> ItemsCart = cartModel.itemsCart;
//     await pref.remove(AppKeys.CACHED_ITEM_CART);

//     return Future.value(unit);
//   }
// }
