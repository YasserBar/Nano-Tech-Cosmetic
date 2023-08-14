import 'package:nano_tech_cosmetic/features/offer/domain/entities/offer_entity.dart';

class OfferModel extends Offer {
  const OfferModel({
    required int id,
    required String title,
    required String titleEn,
    required String description,
    required String descriptionEn,
    required int oldPrice,
    required String price,
    required String? imageUrl,
    required String? videoUrl,
  }) : super(
          id: id,
          title: title,
          titleEn: titleEn,
          description: description,
          descriptionEn: descriptionEn,
          oldPrice: oldPrice,
          price: price,
          imageUrl: imageUrl,
          videoUrl: videoUrl,
        );

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: 5,
      title: json['title'] as String,
      titleEn: json['title_en'] as String,
      description: json['description'] as String,
      descriptionEn: json['description_en'] as String,
      oldPrice: json['old_price'] as int,
      price: json['price'] as String,
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
      'old_price': oldPrice,
      'price': price,
      'image_url': imageUrl,
      'video_url': videoUrl,
    };
  }
}
