import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_keys.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/resend_otp_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/background_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_button_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => di.sl<AuthBloc>(),
        child: BackgroundAuth(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is FailureAuthState ||
                  state is OfflineFailureAuthState ||
                  state is InternalServerFailureAuthState ||
                  state is UnexpectedFailureAuthState) {
                WidgetsUtils.showSnackBar(
                  title: "Failure",
                  message: state.message,
                  snackBarType: SnackBarType.error,
                );
              } else if (state is SuccessResendOTPState) {
                Get.toNamed(AppPagesRoutes.verifyCodeScreen, arguments: {
                  AppKeys.EMAIL: emailController.text,
                });
                WidgetsUtils.showSnackBar(
                  title: "Success",
                  message: state.message,
                  snackBarType: SnackBarType.info,
                );
              }
            },
            builder: (context, state) {
              if (state is LoadingAuthState) {
                return const LoaderIndicator();
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    labelText: "Email",
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  CustomButtonAuth(
                    text: "Send Code",
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        ResendOTPEvent(
                            ResendOTP(
                                email: emailController.text
                            )
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
