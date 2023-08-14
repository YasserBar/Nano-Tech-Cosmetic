import 'package:equatable/equatable.dart';

class Ad extends Equatable {
  final int id;
  final String title;
  final String titleEn;
  final String description;
  final String descriptionEn;
  final int active;
  final String? imageUrl;
  final String? videoUrl;

  const Ad({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.description,
    required this.descriptionEn,
    required this.active,
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
        active,
        imageUrl,
        videoUrl,
      ];
}
