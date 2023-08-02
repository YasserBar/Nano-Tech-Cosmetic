import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/constants/app_keys.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/helpers/pickers.dart';
import 'package:nano_tech_cosmetic/core/helpers/widgets_utils.dart';
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
  bool isMail = true;
  Role roll = Role.customer;

  @override
  void initState() {
    roll = Get.arguments[AppKeys.ROLL];
    super.initState();
  }

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
                  title: "Failure",
                  message: state.message,
                  snackBarType: SnackBarType.error,
                );
              } else if (state is SuccessRegisterState) {
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
                return const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: LoaderIndicator(),
                );
              }
              return Column(
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
                                labelText: "First name",
                                controller: firstNameController,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                labelText: "Last name",
                                controller: lastNameController,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                labelText: "Address",
                                controller: addressController,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                labelText: "Birth date",
                                controller: birthdayController,
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
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Gender",
                                    style: TextStyle(
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
                                    const Text(
                                      "Male",
                                      style: TextStyle(
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
                                    const Text(
                                      "Female",
                                      style: TextStyle(
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
                                labelText: "Email",
                                controller: emailController,
                                inputType: TextInputType.emailAddress,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                labelText: "Password",
                                controller: passwordController,
                                isObscureText: true,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                labelText: "Confirm Password",
                                controller: confirmPasswordController,
                                isObscureText: true,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                labelText: "Phone Number",
                                controller: phoneController,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                labelText: "Instagram",
                                controller: instagramController,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                labelText: "Twitter",
                                controller: twitterController,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                labelText: "Facebook",
                                controller: facebookController,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                labelText: "Telegram",
                                controller: telegramController,
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
                      text: "Sign up",
                      onPressed: () {
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
                    ),
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
