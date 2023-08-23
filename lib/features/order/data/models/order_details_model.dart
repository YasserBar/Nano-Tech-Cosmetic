import 'package:nano_tech_cosmetic/features/offer/data/models/offer_model.dart';
import 'package:nano_tech_cosmetic/features/order/domain/entities/order_details_entity.dart';
import 'package:nano_tech_cosmetic/features/prodect/data/models/product_model.dart';

class OrderDetailsModel extends OrderDetails {
  const OrderDetailsModel({
    required List<ProductModel> products,
    required List<OfferModel> offers,
  }) : super(
          products: products,
          offers: offers,
        );

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    List<ProductModel> products = (json['products'] as List<dynamic>)
        .map((itemJson) => ProductModel.fromJson(itemJson))
        .toList();
    // List<OfferModel> offers = (json['offers'] as List<dynamic>)
    //     .map((itemJson) => OfferModel.fromJson(itemJson))
    //     .toList();
    return OrderDetailsModel(
      products: products,
      offers: const []//offers,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productsJson =
        (products as List<ProductModel>).map((item) => item.toJson()).toList();
    List<Map<String, dynamic>> offersJson =
        (offers as List<OfferModel>).map((item) => item.toJson()).toList();
    return {
      'products': productsJson,
      'offers': offersJson,
    };
  }
}
