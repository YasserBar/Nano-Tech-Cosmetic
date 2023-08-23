import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/screens/main_srcreen.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/screens/Ads_screen.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/screens/ad_details_screen.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/screens/choose_gard_screen.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/screens/signin_screen.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/screens/signup_screen.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/screens/verify_code_screen.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/screens/categories_screen.dart';
import 'package:nano_tech_cosmetic/features/offer/presentation/screens/offer_details_screen.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/screens/my_cart_screen.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/screens/order_details_screen.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/presentation/screens/order_manufacturing_details_screen.dart';
import 'package:nano_tech_cosmetic/features/order_name/presentation/screens/order_name_details_screen.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/screens/product_details_screen.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/screens/products_screen.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/screens/search_screen.dart';

abstract class AppPagesRoutes {
  // Auth
  static const String onBoarding = "/onBoarding";
  static const String signInScreen = "/signInScreen";
  static const String signUpScreen = "/signUpScreen";
  static const String forgetPasswordScreen = "/forgetPasswordScreen";
  static const String verifyCodeScreen = "/verifyCodeScreen";
  static const String resetPasswordScreen = "/resetPasswordScreen";
  static const String chooseGardScreen = "/chooseGardScreen";

  static const String mainScreen = "/";
  static const String searchScreen = "/searchScreen";
  static const String adsScreen = "/adsScreen";
  static const String adDetailsScreen = "/adDetailsScreen";
  static const String myCartScreen = "/myCartScreen";
  static const String myOrderScreen = "/myOrderScreen";
  static const String orderDetailsScreen = "/orderDetailsScreen";
  static const String orderNameDetailsScreen = "/orderNameDetailsScreen";
  static const String orderManufacturingDetailsScreen = "/orderManufacturingDetailsScreen";
  static const String categoriesScreen = "/categoriesScreen";
  static const String productsScreen = "/productsScreen";
  static const String productDetailsScreen = "/productDetailsScreen";
  static const String offerDetailsScreen = "/offerDetailsScreen";

  static List<GetPage<dynamic>> appPages = [
    GetPage(
      name: signInScreen,
      page: () => SignInScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: forgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: verifyCodeScreen,
      page: () => const VerifyCodeScreen(),
      transition: Transition.size,
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => ResetPasswordScreen(),
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
      name: searchScreen,
      page: () => const SearchScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: myCartScreen,
      page: () => const MyCartScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: orderDetailsScreen,
      page: () => OrderDetailsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: orderNameDetailsScreen,
      page: () => OrderNameDetailsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: orderManufacturingDetailsScreen,
      page: () => OrderManufacturingDetailsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: adsScreen,
      page: () => const AdsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: adDetailsScreen,
      page: () => const AdDetailsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: categoriesScreen,
      page: () => const CategoriesScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: productsScreen,
      page: () => const ProductsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: productDetailsScreen,
      page: () => const ProductDetailsScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: offerDetailsScreen,
      page: () => const OfferDetailsScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
