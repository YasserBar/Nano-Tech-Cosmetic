import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/background_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_button_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AuthBloc>(),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is FailureAuthState) {
              WidgetsUtils.showSnackBar(
                title: "Failure",
                message: state.message,
                snackBarType: SnackBarType.error,
              );
            } else if (state is SuccessLoginState) {
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
              return const Center(
                child: SpinKitDualRing(
                  size: 150,
                  color: AppColors.primary,
                ),
              );
            }
            return BackgroundAuth(
              child: Column(
                children: [
                  CustomTextField(
                    labelText: "Email",
                    inputType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                    labelText: "Password",
                    isObscureText: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppPagesRoutes.forgetPasswordScreen);
                        },
                        child: Text(
                          "Forget Password",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: AppColors.secondary, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppPagesRoutes.chooseGardScreen);
                        },
                        child: Text(
                          "sign up",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.secondary,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButtonAuth(
                    text: "Sign in",
                    onPressed: () {
                      // BlocProvider.of<AuthBloc>(context).add(
                      //   LoginEvent(
                      //     Login(
                      //       email: emailController.text,
                      //       password: passwordController.text,
                      //     ),
                      //   ),
                      // );
                      Get.toNamed(AppPagesRoutes.mainScreen);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
