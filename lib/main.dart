import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/user_entity.dart';
import 'package:nano_tech_cosmetic/features/localization/local_controller.dart';
import 'package:nano_tech_cosmetic/injection_countainer.dart' as di;

User? globalUser;
String? globalMessage;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();

  runApp(const MyApp());
}

// void _initializationSplash() async {
//   await Future.delayed(const Duration(seconds: 3));
//   FlutterNativeSplash.remove();
// }


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      title: 'Name',
      debugShowCheckedModeBanner: false,
      locale: controller.language,
      theme: controller.appTheme,
      getPages: AppPagesRoutes.appPages,
      initialRoute: "/",
    );
  }
}
