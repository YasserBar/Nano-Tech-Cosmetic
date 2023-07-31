import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/background_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_button_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  ResetPasswordScreen({super.key});

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
              } else if (state is SuccessResetPasswordState) {
                Get.toNamed(AppPagesRoutes.mainScreen);
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
                children: [
                  const CustomTextField(
                    labelText: "Password",
                    isObscureText: true,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const CustomTextField(
                    labelText: "Confirm password",
                    isObscureText: true,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButtonAuth(
                    text: "Reset",
                    onPressed: () {
                      // if (passwordController.text !=
                      //     confirmPasswordController.text) {
                      //   WidgetsUtils.showSnackBar(
                      //     title: "Failure",
                      //     message: "Password not match confirm password",
                      //     snackBarType: SnackBarType.error,
                      //   );
                      // }
                      // BlocProvider.of<AuthBloc>(context).add(
                      //   ResetPasswordEvent(
                      //       ResetPassword(password: passwordController.text)),
                      // );
                      Get.offAllNamed(AppPagesRoutes.signInScreen);
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
