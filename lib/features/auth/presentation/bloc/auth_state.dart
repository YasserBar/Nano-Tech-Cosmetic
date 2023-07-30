part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoadingAuthState extends AuthState {}

class FailureAuthState extends AuthState {
  final String message;

  const FailureAuthState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessLoginState extends AuthState {
  final String message;

  const SuccessLoginState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessLogoutState extends AuthState {
  final String message;

  const SuccessLogoutState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessVerifyOTPState extends AuthState {
  final String message;

  const SuccessVerifyOTPState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessRegisterState extends AuthState {
  final String message;

  const SuccessRegisterState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessResendOTPState extends AuthState {
  final String message;

  const SuccessResendOTPState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessResetPasswordState extends AuthState {
  final String message;

  const SuccessResetPasswordState({required this.message});

  @override
  List<Object> get props => [message];
}
