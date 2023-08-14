import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String nameEn;
  final String description;
  final String descriptionEn;
  final String imageUrl;

  const Category({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.description,
    required this.descriptionEn,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        nameEn,
        description,
        descriptionEn,
        imageUrl,
      ];
}
