import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';

class ItemCartModel extends ItemCart {
  const ItemCartModel({
    required int id,
    required String title,
    required int price,
    required String? imageUrl,
    required int account,
  }) : super(
          id: id,
          title: title,
          price: price,
          imageUrl: imageUrl,
          account: account,
        );

  factory ItemCartModel.fromJson(Map<String, dynamic> json) {
    return ItemCartModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'] as int,
      imageUrl: json['image_url'] as String?,
      account: json['account'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image_url': imageUrl,
      "account": account,
    };
  }
}
