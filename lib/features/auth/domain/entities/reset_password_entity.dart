import 'package:equatable/equatable.dart';

class ResetPassword extends Equatable {
  final String password;

  const ResetPassword({required this.password});

  @override
  List<Object> get props => [password];
}
