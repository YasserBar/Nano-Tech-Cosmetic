import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/entities/request_order_manufacturing_entity.dart';

class RequestOrderManufacturingModel extends RequestOrderManufacturing {
  const RequestOrderManufacturingModel({
    required String details,
    required int amount,
    required int productId,
    required String? note,
  }) : super(
          details: details,
          amount: amount,
          productId: productId,
          note: note,
        );

  factory RequestOrderManufacturingModel.fromJson(Map<String, dynamic> json) {
    return RequestOrderManufacturingModel(
      details: json['details'] as String,
      amount: json['amount'] as int,
      productId: json['product_id'] as int,
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'details': details,
      'amount': amount,
      'product_id': productId,
      'note': note,
    };
  }
}
