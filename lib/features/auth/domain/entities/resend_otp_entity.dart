import 'package:equatable/equatable.dart';

class ResendOTP extends Equatable {
  final String email;

  const ResendOTP({required this.email});

  @override
  List<Object> get props => [email];
}
