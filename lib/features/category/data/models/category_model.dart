import 'package:nano_tech_cosmetic/features/category/domain/entities/category_entity.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required int id,
    required String name,
    required String description,
    required String imageUrl,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name_en'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
    };
  }
}
