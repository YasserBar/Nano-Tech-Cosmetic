import 'package:equatable/equatable.dart';

class RequestOrder extends Equatable {
  final List<int> productIds;
  final List<int> colorIds;
  final List<int> quantitiesProducts;
  final List<int> offerIds;
  final List<int> quantitiesOffers;

  const RequestOrder({
    required this.productIds,
    required this.colorIds,
    required this.quantitiesProducts,
    required this.offerIds,
    required this.quantitiesOffers,
  });

  @override
  List<Object?> get props => [
        productIds,
        colorIds,
        quantitiesProducts,
        offerIds,
        quantitiesOffers,
      ];
}
