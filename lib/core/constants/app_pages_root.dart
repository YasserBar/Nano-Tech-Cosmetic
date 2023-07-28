
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/features/auth/screens/choose_gard_screen.dart';
import 'package:nano_tech_cosmetic/features/auth/screens/forget_password_screen.dart';
import 'package:nano_tech_cosmetic/features/auth/screens/reset_password_screen.dart';
import 'package:nano_tech_cosmetic/features/auth/screens/signin_screen.dart';
import 'package:nano_tech_cosmetic/features/auth/screens/signup_screen.dart';
import 'package:nano_tech_cosmetic/features/auth/screens/verify_code_screen.dart';
import 'package:nano_tech_cosmetic/features/main_screen/screens/main_srcreen.dart';
import 'package:nano_tech_cosmetic/features/orders/screens/my_cart_screen.dart';
import 'package:nano_tech_cosmetic/features/orders/screens/my_order_screen.dart';
import 'package:nano_tech_cosmetic/features/orders/screens/order_details_screen.dart';

abstract class AppPagesRoutes {
  // Auth
  static const String onBoarding = "/onBoarding";
  static const String signInScreen = "/";
  static const String signUpScreen = "/signUpScreen";
  static const String forgetPasswordScreen = "/forgetPasswordScreen";
  static const String verifyCodeScreen = "/verifyCodeScreen";
  static const String resetPasswordScreen = "/resetPasswordScreen";
  static const String chooseGardScreen = "/chooseGardScreen";

  static const String mainScreen = "/mainScreen";
  static const String myCartScreen = "/myCartScreen";
  static const String myOrderScreen = "/myOrderScreen";
  static const String orderDetailsScreen = "/orderDetailsScreen";

  static List<GetPage<dynamic>> appPages = [
    GetPage(
      name: signInScreen,
      page: () => const SignInScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: forgetPasswordScreen,
      page: () => const ForgetPasswordScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: verifyCodeScreen,
      page: () => const VerifyCodeScreen(),
      transition: Transition.size,
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      transition: Transition.size,
    ),
    GetPage(
      name: signUpScreen,
      page: () => const SignUpScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: chooseGardScreen,
      page: () => const ChooseGardScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: mainScreen,
      page: () => const MainScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: myCartScreen,
      page: () => const MyCartScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: myOrderScreen,
      page: () => const MyOrderScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: orderDetailsScreen,
      page: () => const OrderDetailsScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
