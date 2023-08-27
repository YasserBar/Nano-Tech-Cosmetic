import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final int id;
  final String title;
  final String titleEn;
  final String description;
  final String descriptionEn;
  final int oldPrice;
  final int? ammount;
  final String price;
  final String? imageUrl;
  final String? videoUrl;

  const Offer({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.description,
    required this.descriptionEn,
    required this.oldPrice,
    required this.ammount,
    required this.price,
    required this.imageUrl,
    required this.videoUrl,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        titleEn,
        description,
        descriptionEn,
        oldPrice,
        price,
        imageUrl,
        videoUrl,
      ];
}
