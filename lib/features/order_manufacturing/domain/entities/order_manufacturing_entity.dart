import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';

class OrderManufacturing extends Equatable {
  final int id;
  final String details;
  final String? note;
  final int amount;
  final OrderStatus status;
  final int? cost;
  final int? costManufacture;
  final String? response;
  final String? startProcessing;
  final String? endProcessing;
  final int userId;
  final int productId;
  final String createdAt;
  final String updatedAt;
  final bool availableAmount;

  const OrderManufacturing({
    required this.id,
    required this.details,
    required this.note,
    required this.amount,
    required this.status,
    required this.cost,
    required this.costManufacture,
    required this.response,
    required this.startProcessing,
    required this.endProcessing,
    required this.userId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.availableAmount,
  });

  @override
  List<Object?> get props => [
        id,
        details,
        note,
        amount,
        status,
        cost,
        costManufacture,
        response,
        startProcessing,
        endProcessing,
        userId,
        productId,
        createdAt,
        updatedAt,
        availableAmount,
      ];
}
