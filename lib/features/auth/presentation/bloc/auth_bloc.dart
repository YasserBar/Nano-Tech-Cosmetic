import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano_tech_cosmetic/core/constants/enum_roll.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/login_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/register_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/resend_otp_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/reset_password_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/login_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/logout_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/register_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/resendOTP_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/resetPassword_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/verifyOTP_uasecase.dart';
import 'package:nano_tech_cosmetic/main.dart';

part 'auth_event.dart';
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
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoadingAuthState());

        final failureOrUser = await loginUsecase(event.login);

        emit(
          failureOrUser.fold(
            (failure) => FailureAuthState(message: globalMessage!),
            (user) {
              globalUser = user;
              return SuccessLoginState(message: globalMessage!);
            },
          ),
        );
      } else if (event is LogoutEvent) {
        emit(LoadingAuthState());

        final failureOrDone = await logoutUsecase();

        emit(
          failureOrDone.fold(
            (failure) => FailureAuthState(message: globalMessage!),
            (done) => SuccessLogoutState(message: globalMessage!),
          ),
        );
      } else if (event is RegisterEvent) {
        emit(LoadingAuthState());

        final failureOrDone = await registerUsecase(event.register, event.roll);

        emit(
          failureOrDone.fold(
            (failure) => FailureAuthState(message: globalMessage!),
            (done) => SuccessRegisterState(message: globalMessage!),
          ),
        );
      } else if (event is VerifyOTPEvent) {
        emit(LoadingAuthState());

        final failureOrUser = await verifyOTPUsecase(event.verifyOTP);

        emit(
          failureOrUser.fold(
            (failure) => FailureAuthState(message: globalMessage!),
            (user) {
              globalUser = user;
              return SuccessVerifyOTPState(message: globalMessage!);
            },
          ),
        );
      } else if (event is ResendOTPEvent) {
        emit(LoadingAuthState());

        final failureOrDone = await resendOTPUsecase(event.resendOTP);

        emit(
          failureOrDone.fold(
            (failure) => FailureAuthState(message: globalMessage!),
            (done) => SuccessResendOTPState(message: globalMessage!),
          ),
        );
      } else if (event is ResetPasswordEvent) {
        emit(LoadingAuthState());

        final failureOrDone = await resetPasswordUsecase(event.resetPassword);

        emit(
          failureOrDone.fold(
            (failure) => FailureAuthState(message: globalMessage!),
            (done) => SuccessResendOTPState(message: globalMessage!),
          ),
        );
      }
    });
  }
}
