import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/core/constants/app_messages.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/login_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/logout_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/register_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/resendOTP_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/resetPassword_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/verifyOTP_uasecase.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_event.dart';
import 'package:nano_tech_cosmetic/main.dart';


part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final RegisterUsecase registerUsecase;
  final ResendOTPUsecase resendOTPUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;
  final VerifyOTPUsecase verifyOTPUsecase;

  AuthBloc({
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.registerUsecase,
    required this.resendOTPUsecase,
    required this.resetPasswordUsecase,
    required this.verifyOTPUsecase,
  }) : super(const AuthInitial(message: 'init state ')) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(const LoadingAuthState(message: "loading"));

        final failureOrUser = await loginUsecase(event.login);

        emit(
          failureOrUser.fold(
            (failure) => switchFailure(failure),
            (user) {
              globalUser = user;
              return SuccessLoginState(
                  message: globalMessage ?? "No any message");
            },
          ),
        );
      } else if (event is LogoutEvent) {
        emit(const LoadingAuthState(message: "loading"));

        final failureOrDone = await logoutUsecase();

        emit(
          failureOrDone.fold(
            (failure) => switchFailure(failure),
            (done) =>
                SuccessLogoutState(message: globalMessage ?? "No any message"),
          ),
        );
      } else if (event is RegisterEvent) {
        emit(const LoadingAuthState(message: "loading"));

        final failureOrDone = await registerUsecase(event.register, event.roll);

        emit(
          failureOrDone.fold(
            (failure) => switchFailure(failure),
            (done) => SuccessRegisterState(
                message: globalMessage ?? "No any message"),
          ),
        );
      } else if (event is VerifyOTPEvent) {
        emit(const LoadingAuthState(message: "loading"));

        final failureOrUser = await verifyOTPUsecase(event.verifyOTP);

        emit(
          failureOrUser.fold(
            (failure) => switchFailure(failure),
            (user) {
              globalUser = user;
              return SuccessVerifyOTPState(
                  message: globalMessage ?? "No any message");
            },
          ),
        );
      } else if (event is ResendOTPEvent) {
        emit(const LoadingAuthState(message: "loading"));

        final failureOrDone = await resendOTPUsecase(event.resendOTP);

        emit(
          failureOrDone.fold(
            (failure) => switchFailure(failure),
            (done) => SuccessResendOTPState(
                message: globalMessage ?? "No any message"),
          ),
        );
      } else if (event is ResetPasswordEvent) {
        emit(const LoadingAuthState(message: "loading"));

        final failureOrDone = await resetPasswordUsecase(event.resetPassword);

        emit(
          failureOrDone.fold(
            (failure) => switchFailure(failure),
            (done) => SuccessResetPasswordState(
                message: globalMessage ?? "No any message"),
          ),
        );
      }
    });
  }
}

AuthState switchFailure(failure) {
  if (failure is OfflineFailure) {
    return const OfflineFailureAuthState();
  } else if (failure is InternalServerErrorFailure) {
    return const InternalServerFailureAuthState();
  } else if (failure is UnexpectedFailure) {
    return const UnexpectedFailureAuthState();
  }
  return FailureAuthState(message: globalMessage ?? "No any message");
}
