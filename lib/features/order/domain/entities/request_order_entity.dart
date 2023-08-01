import 'package:equatable/equatable.dart';

class RequestOrder extends Equatable {
  final List<int> productIds;
  final List<int> quantities;

  const RequestOrder({
    required this.productIds,
    required this.quantities,
  });

  @override
  List<Object?> get props => [
        productIds,
        quantities,
      ];
}
