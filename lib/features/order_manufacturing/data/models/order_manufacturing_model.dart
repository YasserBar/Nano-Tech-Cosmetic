import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/features/order/data/models/order_model.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/entities/order_manufacturing_entity.dart';

class OrderManufacturingModel extends OrderManufacturing {
  const OrderManufacturingModel({
    required int id,
    required String details,
    required String? note,
    required int amount,
    required OrderStatus status,
    required int? cost,
    required int? costManufacture,
    required String? response,
    required String? startProcessing,
    required String? endProcessing,
    required int userId,
    required int productId,
    required String createdAt,
    required String updatedAt,
    required bool availableAmount,
  }) : super(
          id: id,
          details: details,
          note: note,
          amount: amount,
          status: status,
          cost: cost,
          costManufacture: costManufacture,
          response: response,
          startProcessing: startProcessing,
          endProcessing: endProcessing,
          userId: userId,
          productId: productId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          availableAmount: availableAmount,
        );

  factory OrderManufacturingModel.fromJson(Map<String, dynamic> json) {
    return OrderManufacturingModel(
      id: json['id'] as int,
      details: json['details'] as String,
      note: json['note'] as String?,
      amount: json['ammount'] as int,
      status: switchToOrderStatus(json['status'] as int),
      cost: json['cost'] as int?,
      costManufacture: json['costManufacture'] as int?,
      response: json['response'] as String?,
      startProcessing: json['start_processing'] as String?,
      endProcessing: json['end_processing'] as String?,
      userId: json['user_id'] as int,
      productId: json['product_id'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      availableAmount: json['avilable_ammount'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'details': details,
      'note': note,
      'ammount': amount,
      'status': switchFromOrderStatus(status),
      'cost': cost,
      'costManufacture': costManufacture,
      'response': response,
      'start_processing': startProcessing,
      'end_processing': endProcessing,
      'user_id': userId,
      'product_id': productId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'avilable_ammount': availableAmount,
    };
  }
}
