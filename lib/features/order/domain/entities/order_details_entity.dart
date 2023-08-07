import 'package:equatable/equatable.dart';
import 'package:nano_tech_cosmetic/features/offer/domain/entities/offer_entity.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/entities/product_entity.dart';

class OrderDetails extends Equatable {
  final List<Product> products;
  final List<Offer> offers;

  const OrderDetails({
    required this.products,
    required this.offers,
  });

  @override
  List<Object?> get props => [
        products,
        offers,
      ];
}
