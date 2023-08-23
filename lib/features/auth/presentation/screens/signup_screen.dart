import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_translation_keys.dart';
import 'package:nano_tech_cosmetic/core/helpers/pickers.dart';
import 'package:nano_tech_cosmetic/core/helpers/regex.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
import 'package:nano_tech_cosmetic/core/widgets/handle_states_widget.dart';
import 'package:nano_tech_cosmetic/core/widgets/loader_indicator.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/register_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_event.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/background_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_button_auth.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController telegramController = TextEditingController();
  final GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();

  bool isMail = false;
  Role roll = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => di.sl<AuthBloc>(),
        child: BackgroundAuth(
          isSignUpScreen: true,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is FailureAuthState) {
                WidgetsUtils.showSnackBar(
                  title: AppTranslationKeys.failure.tr,
                  message: state.message.tr,
                  snackBarType: SnackBarType.error,
                );
              } else if (state is SuccessRegisterState) {
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
                  stateType: StateType.offline,
                  onPressedTryAgain: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      RegisterEvent(
                        Register(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          gender: isMail ? 'male' : 'female',
                          birthday: birthdayController.text,
                          address: addressController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          facebook: facebookController.text,
                          twitter: twitterController.text,
                          instagram: instagramController.text,
                          telegram: telegramController.text,
                        ),
                        roll,
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
                      RegisterEvent(
                        Register(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          gender: isMail ? 'male' : 'female',
                          birthday: birthdayController.text,
                          address: addressController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          facebook: facebookController.text,
                          twitter: twitterController.text,
                          instagram: instagramController.text,
                          telegram: telegramController.text,
                        ),
                        roll,
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
                      RegisterEvent(
                        Register(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          gender: isMail ? 'male' : 'female',
                          birthday: birthdayController.text,
                          address: addressController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          facebook: facebookController.text,
                          twitter: twitterController.text,
                          instagram: instagramController.text,
                          telegram: telegramController.text,
                        ),
                        roll,
                      ),
                    );
                  },
                );
              }
              if (state is LoadingAuthState) {
                return const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: LoaderIndicator(),
                );
              }
              return Form(
                key: formKeySignUp,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: Get.height * 0.75,
                      child: ListView(
                        padding: const EdgeInsets.only(top: 25),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTextField(
                                  labelText: AppTranslationKeys.firstName.tr,
                                  controller: firstNameController,
                                  validator: (val) =>
                                      AppValidator.validateName(val),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                CustomTextField(
                                  labelText: AppTranslationKeys.lastName.tr,
                                  controller: lastNameController,
                                  validator: (val) =>
                                      AppValidator.validateName(val),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                CustomTextField(
                                  labelText: AppTranslationKeys.address.tr,
                                  controller: addressController,
                                  validator: (val) =>
                                      AppValidator.validateRequired(val),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                CustomTextField(
                                  labelText: AppTranslationKeys.birthDate.tr,
                                  controller: birthdayController,
                                  validator: (val) =>
                                      AppValidator.validateRequired(val),
                                  onTap: () async {
                                    String? date =
                                        await Pickers.choseDate(context);
                                    if (date != null) {
                                      birthdayController.text = date;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppTranslationKeys.gender.tr,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: AppColors.gray,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isMail = false;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: !isMail,
                                        side: const BorderSide(
                                          color: AppColors.secondary,
                                          width: 2,
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            isMail = false;
                                          });
                                        },
                                      ),
                                      Text(
                                        AppTranslationKeys.female.tr,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.gray,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isMail = true;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: isMail,
                                        side: const BorderSide(
                                          color: AppColors.secondary,
                                          width: 2,
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            isMail = true;
                                          });
                                        },
                                      ),
                                      Text(
                                        AppTranslationKeys.male.tr,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.gray,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  labelText: AppTranslationKeys.email.tr,
                                  controller: emailController,
                                  inputType: TextInputType.emailAddress,
                                  validator: (val) =>
                                      AppValidator.validateEmail(val),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                CustomTextField(
                                  labelText: AppTranslationKeys.password.tr,
                                  controller: passwordController,
                                  isObscureText: true,
                                  validator: (val) =>
                                      AppValidator.validatePassword(val),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                CustomTextField(
                                  labelText:
                                      AppTranslationKeys.confirmPassword.tr,
                                  controller: confirmPasswordController,
                                  isObscureText: true,
                                  validator: (val) =>
                                      AppValidator.validateConflictPassword(
                                          val, passwordController.text),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                CustomTextField(
                                  labelText: AppTranslationKeys.phoneNumber.tr,
                                  controller: phoneController,
                                  validator: (val) =>
                                      AppValidator.validatePhone(val),
                                  inputType: TextInputType.phone,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                CustomTextField(
                                  labelText: AppTranslationKeys.instagram.tr,
                                  controller: instagramController,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                CustomTextField(
                                  labelText: AppTranslationKeys.twitter.tr,
                                  controller: twitterController,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                CustomTextField(
                                  labelText: AppTranslationKeys.facebook.tr,
                                  controller: facebookController,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                CustomTextField(
                                  labelText: AppTranslationKeys.telegram.tr,
                                  controller: telegramController,
                                  textInputAction: TextInputAction.done,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomButtonAuth(
                        text: AppTranslationKeys.singUp.tr,
                        onPressed: () {
                          if (formKeySignUp.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                              RegisterEvent(
                                Register(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  gender: isMail ? 'male' : 'female',
                                  birthday: birthdayController.text,
                                  address: addressController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  facebook: facebookController.text,
                                  twitter: twitterController.text,
                                  instagram: instagramController.text,
                                  telegram: telegramController.text,
                                ),
                                roll,
                              ),
                            );
                          }
                        },
                      ),
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
