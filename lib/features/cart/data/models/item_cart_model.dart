import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';

class ItemCartModel extends ItemCart {
  ItemCartModel({
    required int id,
    required String title,
    required int price,
    required String? imageUrl,
    required int account,
    bool isProduct = true,
  }) : super(
          id: id,
          title: title,
          price: price,
          imageUrl: imageUrl,
          account: account,
          isProduct: isProduct,
        );

  factory ItemCartModel.fromJson(Map<String, dynamic> json) {
    return ItemCartModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'] as int,
      imageUrl: json['image_url'] as String?,
      account: json['account'] as int,
      isProduct: json['isProduct'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image_url': imageUrl,
      "account": account,
      "isProduct": isProduct,
    };
  }
}
