// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:upkeep_plus/core/constants/keys.dart';
// import 'package:upkeep_plus/features/auth/presentation/pages/login_screen.dart';
// import 'main.dart';

// import 'core/widgets/navigation_customer.dart';
// import 'features/auth/data/datasources/auth_local_data_source.dart';
// import 'features/auth/domain/entities/response_auth.dart';
// import 'features/auth/presentation/pages/my_foundations_screeen.dart';
// import 'features/onboarding/presentation/pages/onboarding_screen.dart';
// import 'injection_countainer.dart' as di;

// class RootScreen extends StatefulWidget {
//   const RootScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _RootScreenState createState() => _RootScreenState();
// }

// class _RootScreenState extends State<RootScreen> {
//   String? _token;
//   bool? _customer;
//   bool? _firstTime;

//   @override
//   void initState() {
//     super.initState();
//     _initializeTokenAndCustomer();
//     _initializationSplash();
//   }

//   void _initializationSplash() async {
//     await Future.delayed(const Duration(seconds: 3));
//     FlutterNativeSplash.remove();
//   }

//   Future<void> _initializeTokenAndCustomer() async {
//     if (kDebugMode) {
//       print("token  $token*************************************************");
//     }
//     try {
//       _firstTime = di.sl<SharedPreferences>().getBool(FIRST_TIME);
//       ResponseAuth responseAuth =
//           await di.sl<AuthLocalDataSource>().getCachedResponse();
//       _token = responseAuth.token;
//       _customer = di.sl<SharedPreferences>().getBool("CUSTOMER");
//       if (kDebugMode) {
//         print(
//             "_token $_token*************************************************");
//         print(
//             "_customer $_customer*************************************************");
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//       _token = null;
//     }
//     token = _token;
//     if (kDebugMode) {
//       print(
//           "equale token:  ${token == _token}*************************************************");
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_token == null && _firstTime == null) {
//       return const OnboardingScreen();
//     } else if (_token == null && _firstTime == false) {
//       return const LoginScreen();
//     } else if (_customer!) {
//       return const NavigationCustomer();
//     } else {
//       return const MyFoundationsScreen();
//     }
//   }
// }
