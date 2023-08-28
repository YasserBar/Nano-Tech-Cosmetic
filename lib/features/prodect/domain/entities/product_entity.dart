import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String nameEn;
  final int price;
  final String description;
  final String descriptionEn;
  final int amount;
  final int categoryId;
  final String categoryName;
  final String categoryNameEn;
  final String imageUrl;
  final double rating;
  final int ratingNumber;

  const Product({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.price,
    required this.description,
    required this.descriptionEn,
    required this.amount,
    required this.categoryId,
    required this.categoryName,
    required this.categoryNameEn,
    required this.imageUrl,
    required this.rating,
    required this.ratingNumber,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        nameEn,
        price,
        description,
        descriptionEn,
        amount,
        categoryId,
        imageUrl,
        rating,
        ratingNumber,
      ];
}
