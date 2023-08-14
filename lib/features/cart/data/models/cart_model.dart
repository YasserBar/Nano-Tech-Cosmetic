import 'package:nano_tech_cosmetic/features/cart/data/models/item_cart_model.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/cart_entity.dart';

class CartModel extends Cart {
  CartModel({
    required int totalPrice,
    required List<ItemCartModel> itemsCart,
  }) : super(
          totalPrice: totalPrice,
          itemsCart: itemsCart,
        );
  factory CartModel.fromJson(Map<String, dynamic> json) {
    List<ItemCartModel> parsedItemsCart = (json['itemsCart'] as List<dynamic>)
        .map<ItemCartModel>((itemJson) => ItemCartModel.fromJson(itemJson))
        .toList();
    // List<ItemCartModel> parsedItemsCart = json['itemsCart']
    //     .map((itemJson) => ItemCartModel.fromJson(itemJson))
    //     .toList();
    return CartModel(
      totalPrice: json['totalPrice'] as int,
      itemsCart: parsedItemsCart,
    );
  }
  // List<dynamic> itemsCartJson = json['itemsCart'];

  //   List<ItemCartModel> parsedItemsCart = itemsCartJson
  //       .map((itemJson) => ItemCartModel.fromJson(itemJson))
  //       .toList();

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemsCartJson =
        (itemsCart as List<ItemCartModel>)
            .map((item) => item.toJson())
            .toList();
    return {
      'totalPrice': totalPrice,
      'itemsCart': itemsCartJson,
    };
  }
}
  //  List<ItemCartModel> itemsCartModel = itemsCart as List<ItemCartModel>;
  //   List<Map<String, dynamic>> itemsCartJson =
  //       itemsCartModel.map((item) => item.toJson()).toList();