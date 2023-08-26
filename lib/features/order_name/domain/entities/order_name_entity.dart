import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';

class OrderName extends Equatable {
  final int id;
  final String newName;
  final String? note;
  final int amount;
  final OrderStatus status;
  final int cost;
  final int? costPrinting;
  final String? response;
  final String? startProcessing;
  final String? endProcessing;
  final int userId;
  final int productId;
  final String createdAt;
  final String updatedAt;
  final bool availableAmount;

  const OrderName({
    required this.id,
    required this.newName,
    required this.note,
    required this.amount,
    required this.status,
    required this.cost,
    required this.costPrinting,
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
        newName,
        note,
        amount,
        status,
        cost,
        costPrinting,
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
