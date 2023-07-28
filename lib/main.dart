import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/constants/app_pages_root.dart';
import 'package:nano_tech_cosmetic/core/constants/app_themes.dart';


String? token;
int? globalFoundationId;
bool? isActive;

late BuildContext globalContext;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
      // [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await di.init();
  runApp(const MyApp());
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
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (_) => di.sl<AuthBloc>(),
    //     ),
    //     BlocProvider<AddJobBloc>(create: (_) => di.sl<AddJobBloc>()),
    //     BlocProvider<GetLocationsBloc>(
    //       create: (_) => di.sl<GetLocationsBloc>(),
    //     ),
    //     BlocProvider<SubServiceBloc>(
    //       create: (_) => di.sl<SubServiceBloc>(),
    //     ),
    //     BlocProvider<CategoriesBloc>(
    //       create: (_) => di.sl<CategoriesBloc>()
    //         ..add(
    //           const GetAllCategoriesEvent(),
    //         ),
    //     ),
    //   ],
    //   child: MaterialApp(
    //     home: const RootScreen(),
    //     debugShowCheckedModeBanner: false,
    //     title: 'Upkeep+',
    //     theme: ThemeData(
    //       scaffoldBackgroundColor: backgroundColor,
    //       primaryColor: primaryColor,
    //     ),
    //   ),
    // );
  }
}
