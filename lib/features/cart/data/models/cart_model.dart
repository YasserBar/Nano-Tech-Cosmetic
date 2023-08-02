import 'package:nano_tech_cosmetic/features/cart/data/models/item_cart_model.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/entities/cart_entity.dart';

class CartModel extends Cart {
  const CartModel({
    required int totalPrice,
    required List<ItemCartModel> itemsCart,
  }) : super(
          totalPrice: totalPrice,
          itemsCart: itemsCart,
        );
  factory CartModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productIds = json['product_ids'];
    List<dynamic> quantities = json['quantities'];

    assert(productIds.length == quantities.length);

    List<ItemCartModel> parsedProductIds = productIds.cast<ItemCartModel>();

    return CartModel(
      totalPrice: json['totalPrice'] as int,
      itemsCart: parsedProductIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPrice': totalPrice,
      'itemsCart': itemsCart,
    };
  }
}
