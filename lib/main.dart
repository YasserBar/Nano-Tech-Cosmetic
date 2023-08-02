import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_themes.dart';
import 'package:nano_tech_cosmetic/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/user_entity.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

User? globalUser;
String? globalMessage;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();
  _initializeTokenAndCustomer();
  runApp(const MyApp());
}

// void _initializationSplash() async {
//   await Future.delayed(const Duration(seconds: 3));
//   FlutterNativeSplash.remove();
// }

Future<void> _initializeTokenAndCustomer() async {
  try {
    globalUser = await di.sl<AuthLocalDataSource>().getCachedUser();
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Name',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.themeEnglish,
      getPages: AppPagesRoutes.appPages,
      initialRoute: "/",
    );
  }
}
