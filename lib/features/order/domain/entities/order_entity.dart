import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';

class Order extends Equatable {
  final int id;
  final OrderStatus status;
  final String langCode;
  final int price;
  final int userId;
  final String? response;
  final String? startProcessing;
  final String? endProcessing;
  final String createdAt;
  final String updatedAt;
  // final AvailableAmount availableAmount;

  const Order({
    required this.id,
    required this.status,
    required this.langCode,
    required this.price,
    required this.userId,
    required this.response,
    required this.startProcessing,
    required this.endProcessing,
    required this.createdAt,
    required this.updatedAt,
    // required this.availableAmount,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        langCode,
        price,
        userId,
        response,
        startProcessing,
        endProcessing,
        createdAt,
        updatedAt,
        // availableAmount,
      ];
}

// class AvailableAmount extends Equatable {
//   final bool state;
//   // final List<int> productIdsUnavailable;

//   const AvailableAmount({
//     required this.state,
//     // required this.productIdsUnavailable,
//   });

//   @override
//   List<Object?> get props => [state];
// }
