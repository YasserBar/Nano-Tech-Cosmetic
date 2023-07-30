import 'package:nano_tech_cosmetic/features/prodect/domain/entities/product_entity.dart';

class ProductModel extends Product {
  const ProductModel({
    required int id,
    required String name,
    required int price,
    required String description,
    required int amount,
    required int categoryId,
    required String imageUrl,
    required int rating,
    required int ratingNumber,
  }) : super(
          id: id,
          name: name,
          price: price,
          description: description,
          amount: amount,
          categoryId: categoryId,
          imageUrl: imageUrl,
          rating: rating,
          ratingNumber: ratingNumber,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      amount: json['ammount'] as int,
      categoryId: json['category_id'] as int,
      imageUrl: json['image_url'] as String,
      rating: json['rating'] as int,
      ratingNumber: json['rating_number'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'ammount': amount,
      'category_id': categoryId,
      'image_url': imageUrl,
      'rating': rating,
      'rating_number': ratingNumber,
    };
  }
}
