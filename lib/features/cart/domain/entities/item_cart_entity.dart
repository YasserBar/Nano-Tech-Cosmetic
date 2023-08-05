import 'package:equatable/equatable.dart';

class ItemCart extends Equatable {
  final int id;
  final String title;
  final int price;
  final String? imageUrl;
  final int account;
  final bool isProduct;

  const ItemCart({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.account,
    required this.isProduct,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        imageUrl,
        account,
        isProduct,
      ];
}
