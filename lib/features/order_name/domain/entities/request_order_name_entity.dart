import 'package:equatable/equatable.dart';

class RequestOrderName extends Equatable {
  final String newName;
  final int amount;
  final int productId;
  final String? note;

  const RequestOrderName({
    required this.newName,
    required this.amount,
    required this.productId,
    required this.note,
  });

  @override
  List<Object?> get props => [newName, amount, productId, note];
}
