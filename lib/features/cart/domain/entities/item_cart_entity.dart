import 'package:equatable/equatable.dart';

class ItemCart extends Equatable {
  final int id;
  final String title;
  final int price;
  final String? imageUrl;
  int account;
  final bool isProduct;

   ItemCart({
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
