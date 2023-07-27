import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'root_screen.dart';
// import 'core/constants/app_colors.dart';
// import 'features/ads&jobs/presentation/bloc/add_job_bloc/add_job_bloc.dart';
// import 'features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
// import 'features/categories/presentation/bloc/categories/categories_bloc.dart';
// import 'features/categories/presentation/bloc/subservice/subservice_bloc.dart';
// import 'features/locations/presentation/bloc/getLocations/get_locations_bloc.dart';
// import 'injection_countainer.dart' as di;

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
    return Container();
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
