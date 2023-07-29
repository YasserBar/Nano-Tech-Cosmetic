import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
      ];
}
