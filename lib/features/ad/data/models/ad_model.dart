import 'package:nano_tech_cosmetic/features/ad/domain/entities/ad_entity.dart';

class AdModel extends Ad {
  const AdModel({
    required int id,
    required String title,
    required String titleEn,
    required String description,
    required String descriptionEn,
    required int active,
    required String? imageUrl,
    required String? videoUrl,
  }) : super(
          id: id,
          title: title,
          titleEn: titleEn,
          description: description,
          descriptionEn: descriptionEn,
          active: active,
          imageUrl: imageUrl,
          videoUrl: videoUrl,
        );

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'] as int,
      title: json['title'] as String,
      titleEn: json['title_en'] as String,
      description: json['description'] as String,
      descriptionEn: json['description_en'] as String,
      active: json['active'] as int,
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'title_en': title,
      'description': description,
      'description_en': description,
      'active': active,
      'image_url': imageUrl,
      'video_url': videoUrl,
    };
  }
}
