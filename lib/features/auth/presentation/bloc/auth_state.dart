part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final String message;

  const AuthState({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthInitial extends AuthState {
  const AuthInitial({required super.message});
}

class LoadingAuthState extends AuthState {
  const LoadingAuthState({required super.message});
}

class FailureAuthState extends AuthState {
  const FailureAuthState({required super.message});
}

class InternalServerFailureAuthState extends AuthState {
  const InternalServerFailureAuthState(
      {super.message = AppMessages.internalServerError});
}

class UnexpectedFailureAuthState extends AuthState {
  const UnexpectedFailureAuthState(
      {super.message = AppMessages.unexpectedException});
}

class OfflineFailureAuthState extends AuthState {
  const OfflineFailureAuthState({super.message = AppMessages.offline});
}

class SuccessLoginState extends AuthState {
  const SuccessLoginState({required super.message});
}

class SuccessLogoutState extends AuthState {
  const SuccessLogoutState({required super.message});
}

class SuccessVerifyOTPState extends AuthState {
  const SuccessVerifyOTPState({required super.message});
}

class SuccessRegisterState extends AuthState {
  const SuccessRegisterState({required super.message});
}

class SuccessResendOTPState extends AuthState {
  const SuccessResendOTPState({required super.message});
}

class SuccessResetPasswordState extends AuthState {
  const SuccessResetPasswordState({required super.message});
}
