import 'package:equatable/equatable.dart';

class VerifyOTP extends Equatable {
  final String otp;

  const VerifyOTP({required this.otp});

  @override
  List<Object> get props => [otp];
}
