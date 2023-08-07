import 'package:equatable/equatable.dart';

class RequestOrderManufacturing extends Equatable {
  final String details;
  final int amount;
  final int productId;
  final String? note;

  const RequestOrderManufacturing({
    required this.details,
    required this.amount,
    required this.productId,
    required this.note,
  });

  @override
  List<Object?> get props => [details, amount, productId, note];
}
