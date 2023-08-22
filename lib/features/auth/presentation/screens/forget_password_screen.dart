import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/regex.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/handle_states_widget.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/resend_otp_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_event.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/background_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_button_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKeyForgetPassword = GlobalKey<FormState>();

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => di.sl<AuthBloc>(),
        child: BackgroundAuth(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is FailureAuthState) {
                WidgetsUtils.showSnackBar(
                  title: AppTranslationKeys.failure.tr,
                  message: state.message.tr,
                  snackBarType: SnackBarType.error,
                );
              } else if (state is SuccessResendOTPState) {
                Get.toNamed(AppPagesRoutes.verifyCodeScreen,
                    arguments: emailController.text);
                WidgetsUtils.showSnackBar(
                  title: AppTranslationKeys.success.tr,
                  message: state.message.tr,
                  snackBarType: SnackBarType.info,
                );
              }
            },
            builder: (context, state) {
              if (state is OfflineFailureAuthState) {
                return HandleStatesWidget(
                  isDialog: true,
                  errorType: StateType.offline,
                  onPressedTryAgain: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      ResendOTPEvent(ResendOTP(email: emailController.text)),
                    );
                  },
                );
              }
              if (state is UnexpectedFailureAuthState) {
                return HandleStatesWidget(
                  isDialog: true,
                  errorType: StateType.unexpectedProblem,
                  onPressedTryAgain: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      ResendOTPEvent(ResendOTP(email: emailController.text)),
                    );
                  },
                );
              }
              if (state is InternalServerFailureAuthState) {
                return HandleStatesWidget(
                  isDialog: true,
                  errorType: StateType.internalServerProblem,
                  onPressedTryAgain: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      ResendOTPEvent(ResendOTP(email: emailController.text)),
                    );
                  },
                );
              }
              if (state is LoadingAuthState) {
                return const LoaderIndicator();
              }
              return Form(
                key: formKeyForgetPassword,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      labelText: AppTranslationKeys.email.tr,
                      controller: emailController,
                      textInputAction: TextInputAction.done,
                      inputType: TextInputType.emailAddress,
                      validator: (val) => AppValidator.validateEmail(val),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    CustomButtonAuth(
                      text: AppTranslationKeys.sendCode.tr,
                      onPressed: () {
                        if (formKeyForgetPassword.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            ResendOTPEvent(
                                ResendOTP(email: emailController.text)),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
