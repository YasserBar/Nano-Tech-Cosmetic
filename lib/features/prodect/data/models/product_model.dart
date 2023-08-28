import 'package:nano_tech_cosmetic/features/prodect/domain/entities/product_entity.dart';

class ProductModel extends Product {
  const ProductModel({
    required int id,
    required String name,
    required String nameEn,
    required int price,
    required String description,
    required String descriptionEn,
    required int amount,
    required int categoryId,
    required String imageUrl,
    required String categoryName,
    required String categoryNameEn,
    required double rating,
    required int ratingNumber,
  }) : super(
          id: id,
          name: name,
          nameEn: nameEn,
          price: price,
          description: description,
          descriptionEn: descriptionEn,
          amount: amount,
          categoryId: categoryId,
          categoryName: categoryName,
          categoryNameEn: categoryNameEn,
          imageUrl: imageUrl,
          rating: rating,
          ratingNumber: ratingNumber,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      nameEn: json['name_en'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      descriptionEn: json['description_en'] as String,
      amount: json['ammount'] as int,
      categoryId: json['category_id'] as int,
      categoryName: json['category_name'] as String,
      categoryNameEn: json['category_name_en'] as String,
      imageUrl: json['image_url'] as String,
      rating: double.parse(json['rating'].toString()),
      ratingNumber: json['rating_number'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_en': nameEn,
      'price': price,
      'description': description,
      'description_en': descriptionEn,
      'ammount': amount,
      'category_id': categoryId,
      'image_url': imageUrl,
      'rating': rating,
      'rating_number': ratingNumber,
    };
  }
}
