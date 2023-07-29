import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final int id;
  final String title;
  final String description;
  final int oldPrice;
  final String price;
  final String? imageUrl;
  final String? videoUrl;

  const Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.oldPrice,
    required this.price,
    required this.imageUrl,
    required this.videoUrl,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        oldPrice,
        price,
        imageUrl,
        videoUrl,
      ];
}
