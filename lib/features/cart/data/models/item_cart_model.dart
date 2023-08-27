import 'package:nano_tech_cosmetic/features/cart/domain/entities/item_cart_entity.dart';

class ItemCartModel extends ItemCart {
  ItemCartModel({
    required int id,
    required String title,
    required String titleEn,
    required int price,
    required String? imageUrl,
    required int account,
    required bool isProduct,
  }) : super(
          id: id,
          title: title,
          titleEn: titleEn,
          price: price,
          imageUrl: imageUrl,
          account: account,
          isProduct: isProduct,
        );

  factory ItemCartModel.fromJson(Map<String, dynamic> json) {
    return ItemCartModel(
      id: json['id'] as int,
      title: json['title'] as String,
      titleEn: json['title_en'] as String,
      price: json['price'] as int,
      imageUrl: json['image_url'] as String?,
      account: json['account'] as int,
      isProduct: json['isProduct'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'title_en': titleEn,
      'price': price,
      'image_url': imageUrl,
      "account": account,
      "isProduct": isProduct,
    };
  }
}
