import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_keys.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/resend_otp_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_event.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/background_auth.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  String email = '';

  @override
  void initState() {
    email = Get.arguments[AppKeys.EMAIL];
    super.initState();
  }

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
                  title: "Failure",
                  message: state.message,
                  snackBarType: SnackBarType.error,
                );
              } else if (state is SuccessVerifyOTPState) {
                Get.toNamed(AppPagesRoutes.resetPasswordScreen);
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
                  Text(
                    "We send verify code to",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 20,
                        ),
                  ),
                  Text(
                    email,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 19, color: AppColors.secondary),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Verify Code",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.gray,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    borderWidth: 3,
                    borderColor: AppColors.gray,
                    showFieldAsBox: true,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    borderRadius: BorderRadius.circular(15),
                    autoFocus: true,
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      BlocProvider.of<AuthBloc>(context).add(
                        VerifyOTPEvent(
                          VerifyOTP(otp: verificationCode),
                        ),
                      );
                    }, // end onSubmit
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            ResendOTPEvent(
                              ResendOTP(email: email),
                            ),
                          );
                        },
                        child: const Text(
                          "resend",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
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
