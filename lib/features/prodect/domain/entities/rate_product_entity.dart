import 'package:equatable/equatable.dart';

class RateProduct extends Equatable {
  final int rate;
  final int productId;

  const RateProduct({required this.productId, required this.rate});

  @override
  List<Object> get props => [rate,productId];
}
