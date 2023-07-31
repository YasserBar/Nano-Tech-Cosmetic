import 'package:nano_tech_cosmetic/features/order/domain/entities/request_order_entity.dart';

class RequestOrderModel extends RequestOrder {
  const RequestOrderModel({
    required List<int> productIds,
    required List<int> quantities,
  }) : super(
          productIds: productIds,
          quantities: quantities,
        );

  factory RequestOrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productIds = json['product_ids'];
    List<dynamic> quantities = json['quantities'];

    assert(productIds.length == quantities.length);

    List<int> parsedProductIds = productIds.cast<int>();
    List<int> parsedQuantities = quantities.cast<int>();

    return RequestOrderModel(
      productIds: parsedProductIds,
      quantities: parsedQuantities,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_ids': productIds,
      'quantities': quantities,
    };
  }
}
