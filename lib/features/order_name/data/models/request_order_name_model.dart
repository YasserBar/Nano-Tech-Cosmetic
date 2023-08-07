import 'package:nano_tech_cosmetic/features/order_name/domain/entities/request_order_name_entity.dart';

class RequestOrderNameModel extends RequestOrderName {
  const RequestOrderNameModel({
    required String newName,
    required int amount,
    required int productId,
    required String? note,
  }) : super(
          newName: newName,
          amount: amount,
          productId: productId,
          note: note,
        );

  factory RequestOrderNameModel.fromJson(Map<String, dynamic> json) {
    return RequestOrderNameModel(
      newName: json['new_name'] as String,
      amount: json['amount'] as int,
      productId: json['product_id'] as int,
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'new_name': newName,
      'amount': amount,
      'product_id': productId,
      'note': note,
    };
  }
}
