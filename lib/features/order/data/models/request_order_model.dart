import 'package:nano_tech_cosmetic/features/order/domain/entities/request_order_entity.dart';

class RequestOrderModel extends RequestOrder {
  const RequestOrderModel({
    required List<int> productIds,
    required List<int> colorIds,
    required List<int> quantitiesProducts,
    required List<int> offerIds,
    required List<int> quantitiesOffers,
  }) : super(
          productIds: productIds,
          colorIds: colorIds,
          quantitiesProducts: quantitiesProducts,
          offerIds: offerIds,
          quantitiesOffers: quantitiesOffers,
        );

  factory RequestOrderModel.fromJson(Map<String, dynamic> json) {
    return RequestOrderModel(
      productIds: List<int>.from(json['product_ids'] as List),
      colorIds: List<int>.from(json['color_ids'] as List),
      quantitiesProducts: List<int>.from(json['quantities_products'] as List),
      offerIds: List<int>.from(json['offer_ids'] as List),
      quantitiesOffers: List<int>.from(json['quantities_offers'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_ids': productIds,
      'color_ids': colorIds,
      'quantities_products': quantitiesProducts,
      'offer_ids': offerIds,
      'quantities_offers': quantitiesOffers,
    };
  }
}
