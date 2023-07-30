import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final int price;
  final String description;
  final int amount;
  final int categoryId;
  final String imageUrl;
  final int rating;
  final int ratingNumber;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.amount,
    required this.categoryId,
    required this.imageUrl,
    required this.rating,
    required this.ratingNumber,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        description,
        amount,
        categoryId,
        imageUrl,
        rating,
        ratingNumber,
      ];
}
