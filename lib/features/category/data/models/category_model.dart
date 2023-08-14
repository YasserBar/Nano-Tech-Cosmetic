import 'package:nano_tech_cosmetic/features/category/domain/entities/category_entity.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required int id,
    required String name,
    required String nameEn,
    required String description,
    required String descriptionEn,
    required String imageUrl,
  }) : super(
          id: id,
          name: name,
          nameEn: nameEn,
          description: description,
          descriptionEn: descriptionEn,
          imageUrl: imageUrl,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      nameEn: json['name_en'] as String,
      description: json['description'] as String,
      descriptionEn: json['description_en'] as String,
      imageUrl: json['image_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_en': nameEn,
      'description': description,
      'description_en': descriptionEn,
      'image_url': imageUrl,
    };
  }
}
