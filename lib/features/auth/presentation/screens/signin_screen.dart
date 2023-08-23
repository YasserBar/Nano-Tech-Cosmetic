import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/regex.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/handle_states_widget.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/login_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_event.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/background_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_button_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();

  SignInScreen({super.key});

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
              } else if (state is SuccessLoginState) {
                Get.offAllNamed(AppPagesRoutes.mainScreen);
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
                  stateType: StateType.offline,
                  onPressedTryAgain: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      LoginEvent(
                        Login(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is UnexpectedFailureAuthState) {
                return HandleStatesWidget(
                  isDialog: true,
                  stateType: StateType.unexpectedProblem,
                  onPressedTryAgain: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      LoginEvent(
                        Login(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is InternalServerFailureAuthState) {
                return HandleStatesWidget(
                  isDialog: true,
                  stateType: StateType.internalServerProblem,
                  onPressedTryAgain: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      LoginEvent(
                        Login(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is LoadingAuthState) {
                return const LoaderIndicator();
              }
              return Form(
                key: formKeySignIn,
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: AppTranslationKeys.email.tr,
                      inputType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (val) => AppValidator.validateEmail(val),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                      labelText: AppTranslationKeys.password.tr,
                      isObscureText: true,
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      validator: (val) => AppValidator.validatePassword(val),
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
                            AppTranslationKeys.forgetPassword.tr,
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
                          AppTranslationKeys.doNotHaveAnAccount.tr,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppPagesRoutes.chooseGardScreen);
                          },
                          child: Text(
                            AppTranslationKeys.singUp.tr,
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
                      text: AppTranslationKeys.singIn.tr,
                      onPressed: () {
                        if (formKeySignIn.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            LoginEvent(
                              Login(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            ),
                          );
                        }
                        // Get.toNamed(AppPagesRoutes.mainScreen);
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
