import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/features/order/domain/entities/order_entity.dart';
import 'package:nano_tech_cosmetic/features/order/domain/entities/order_entity.dart'
    as order;
class OrderModel extends order.Order {
  const OrderModel({
    required int id,
    required OrderStatus status,
    required String langCode,
    required double price,
    required int userId,
    required String response,
    required String startProcessing,
    required String endProcessing,
    required String createdAt,
    required String updatedAt,
    required AvailableAmountModel availableAmount,
  }) : super(
          id: id,
          status: status,
          langCode: langCode,
          price: price,
          userId: userId,
          response: response,
          startProcessing: startProcessing,
          endProcessing: endProcessing,
          createdAt: createdAt,
          updatedAt: updatedAt,
          availableAmount: availableAmount,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int,
      status: switchToOrderStatus(json['status'] as int),
      langCode: json['lang_code'] as String,
      price: json['price'] as double,
      userId: json['user_id'] as int,
      response: json['response'] as String,
      startProcessing: json['start_processing'] as String,
      endProcessing: json['end_processing'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      availableAmount: AvailableAmountModel.fromJson(
        json['avilable_ammount'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': switchFromOrderStatus(status),
      'lang_code': langCode,
      'price': price,
      'user_id': userId,
      'response': response,
      'start_processing': startProcessing,
      'end_processing': endProcessing,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'avilable_ammount': (availableAmount as AvailableAmountModel).toJson(),
    };
  }
}

class AvailableAmountModel extends AvailableAmount {
  const AvailableAmountModel({
    required bool state,
    required List<int> productIdsUnavailable,
  }) : super(
          state: state,
          productIdsUnavailable: productIdsUnavailable,
        );

  factory AvailableAmountModel.fromJson(Map<String, dynamic> json) {
    return AvailableAmountModel(
      state: json['state'] as bool,
      productIdsUnavailable:
          List<int>.from(json['product_ids_unAvilable'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'product_ids_unAvilable': productIdsUnavailable,
    };
  }
}

OrderStatus switchToOrderStatus(int orderStatus) {
  if (orderStatus == 0) {
    return OrderStatus.waiting;
  } else if (orderStatus == 1) {
    return OrderStatus.processing;
  } else if (orderStatus == 2) {
    return OrderStatus.rejected;
  } else {
    return OrderStatus.done;
  }
}

int switchFromOrderStatus(OrderStatus orderStatus) {
  if (orderStatus == OrderStatus.waiting) {
    return 0;
  } else if (orderStatus == OrderStatus.processing) {
    return 1;
  } else if (orderStatus == OrderStatus.rejected) {
    return 2;
  } else {
    return 3;
  }
}
