import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
// //? Features ================================

// //! Feature - Ad
// // Bloc

//   sl.registerFactory(() => AdsBloc(getAdsSlidersUsecase: sl()));
//   sl.registerFactory(() => JobBloc(getJobsSlidersUsecase: sl()));
//   sl.registerFactory(
//       () => AdsFoundationBloc(showAllAdsForFoundationUsecase: sl()));
//   sl.registerFactory(
//       () => GetJopFoundationBloc(showAllJobForFoundationUsecase: sl()));
//   sl.registerFactory(() => AddJobBloc(addJobUsecase: sl()));
// // Usecases

//   sl.registerLazySingleton(() => AddJobUsecase(sl()));
//   sl.registerLazySingleton(() => GetAdsSlidersUsecase(sl()));
//   sl.registerLazySingleton(() => GetJobsSlidersUsecase(sl()));
//   sl.registerLazySingleton(() => ShowAllAdsForFoundationUsecase(sl()));
//   sl.registerLazySingleton(() => ShowAllJobForFoundationUsecase(sl()));
// // Repository
//   sl.registerLazySingleton<AdsAndJobsRepo>(() => AdsAndJobsRepoImpl(
//       remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
// // Datasources
//   sl.registerLazySingleton<AdsAndJobsRemoteDataSource>(
//       () => AdsAndJobsRemoteDataSourceImplWithHttp(client: sl()));

// //! Feature - auth
// // Bloc
//   sl.registerFactory(() => AuthBloc(
//         loginCustomerUsecase: sl(),
//         loginProviderUsecase: sl(),
//         forgetPasswordUsecase: sl(),
//         signupUsecase: sl(),
//         resendPinUsecase: sl(),
//         verifyPinForgetUsecase: sl(),
//         verifyPinSignupUsecase: sl(),
//       ));
//   sl.registerFactory(() => ChangePasswordLogoutBloc(
//         logoutUsecase: sl(),
//         changePasswordUsecase: sl(),
//       ));

// // Usecases
//   sl.registerLazySingleton(() => ChangePasswordUsecase(sl()));
//   sl.registerLazySingleton(() => ForgetPasswordUsecase(sl()));
//   sl.registerLazySingleton(() => LoginCustomerUsecase(sl()));
//   sl.registerLazySingleton(() => LoginProviderUsecase(sl()));
//   sl.registerLazySingleton(() => LogoutUsecase(sl()));
//   sl.registerLazySingleton(() => ResendPinUsecase(sl()));
//   sl.registerLazySingleton(() => SignupUsecase(sl()));
//   sl.registerLazySingleton(() => VerifyPinForgetUsecase(sl()));
//   sl.registerLazySingleton(() => VerifyPinSignupUsecase(sl()));

// // Repository
//   sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
//       remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// // Datasources
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//       () => AuthRemoteDataSourceImplWithHttp(client: sl()));
//   sl.registerLazySingleton<AuthLocalDataSource>(
//       () => AuthLocalDataSourceImplWithSharedPreferences(pref: sl()));

// //! Feature - category
// // Bloc

//   sl.registerFactory(() => CategoriesBloc(getAllServiceInSystemUsecase: sl()));
//   sl.registerFactory(
//       () => SubServiceBloc(getAllSubServiceInSystemUsecase: sl()));

// // Usecases
//   sl.registerLazySingleton(() => GetAllServiceInSystemUsecase(sl()));
//   sl.registerLazySingleton(() => GetAllSubServiceInSystemUsecase(sl()));

// // Repository
//   sl.registerLazySingleton<CategoriesRepo>(() => CategoriesRepoImpl(
//       remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// // Datasources
//   sl.registerLazySingleton<CategoriesRemoteDataSource>(
//       () => CategoriesRemoteDataSourceImplWithHttp(client: sl()));

// //! Feature - offer
// // Bloc
//   sl.registerFactory(() => OrdersCustomerBloc(
//         getAllOrderUsecase: sl(),
//         cancelOrderUsecase: sl(),
//         setAssessmentUsecase: sl(),
//       ));
//   sl.registerFactory(
//       () => OrdersBloc(getAllOrderUsecase: sl(), cancelOrderUsecase: sl()));
//   sl.registerFactory(() => GetAllOrdersBloc(
//       getAllOrderForServiceUsecase: sl(),
//       getAllOrderForFoundationUsecase: sl()));
//   sl.registerFactory(() => AcceptRejectedOrderBloc(
//       acceptOrderUsecase: sl(), rejectedOrderUsecase: sl()));
// // Usecases
//   sl.registerLazySingleton(() => AcceptOrderUsecase(sl()));
//   sl.registerLazySingleton(() => BlockUserFoundationUsecase(sl()));
//   sl.registerLazySingleton(() => BlockUserServiceUsecase(sl()));
//   sl.registerLazySingleton(() => CancelOrderUsecase(sl()));
//   sl.registerLazySingleton(() => GetAllOrderForFoundationUsecase(sl()));
//   sl.registerLazySingleton(() => GetAllOrderForServiceUsecase(sl()));
//   sl.registerLazySingleton(() => GetAllOrderUsecase(sl()));
//   sl.registerLazySingleton(() => RejectedOrderUsecase(sl()));
//   sl.registerLazySingleton(() => SetAssessmentUsecase(sl()));

// // Repository
//   sl.registerLazySingleton<OrderRepo>(() => OrderRepoImpl(sl(), sl(), sl()));

// // Datasources
//   sl.registerLazySingleton<OrderRemoteDataSource>(
//       () => OrderRemoteDataSourceImplWithHttp(client: sl()));

// //! Feature - order
// // Bloc

//   sl.registerFactory(() => AvailableTimeBloc(getAvailableTimeUsecase: sl()));
//   sl.registerFactory(() => ReservationBloc(reservationServiceUsecase: sl()));

//   sl.registerFactory(() => FoundationServicesBloc(
//         getAllServiceForFoundationUsecase: sl(),
//       ));
//   sl.registerFactory(() => AddServiceFoundationBloc(
//         addServiceToFoundationUsecase: sl(),
//       ));
//   sl.registerFactory(() => EditServiceFoundationBloc(
//         editServiceUsecase: sl(),
//       ));
//   sl.registerFactory(() => StopServiceBloc(
//         stopServiceUsecase: sl(),
//       ));

// // Usecases
//   sl.registerLazySingleton(() => AddServiceToFoundationUsecase(sl()));
//   sl.registerLazySingleton(() => EditServiceUsecase(sl()));
//   sl.registerLazySingleton(() => GetAllServiceForFoundationUsecase(sl()));
//   sl.registerLazySingleton(() => GetAvailableTimeUsecase(sl()));
//   sl.registerLazySingleton(() => ReservationServiceUsecase(sl()));
//   sl.registerLazySingleton(() => StopServiceUsecase(sl()));

// // Repository
//   sl.registerLazySingleton<ServiceRepo>(
//       () => ServiceRepoImpl(sl(), sl(), sl()));

// // Datasources
//   sl.registerLazySingleton<ServiceRemoteDataSource>(
//       () => ServiceRemoteDataSourceImplWithHttp(client: sl()));

// //! Feature - prodect
// // Bloc
//   sl.registerFactory(() => GetAllMyProposeBloc(
//         getAllMyProposeUsecase: sl(),
//       ));
//   sl.registerFactory(() => ProposeNewServiceBloc(
//         proposeNewServiceUsecase: sl(),
//       ));

// // Usecases
//   sl.registerLazySingleton(() => GetAllMyProposeUsecase(sl()));
//   sl.registerLazySingleton(() => ProposeNewServiceUsecase(sl()));

// // Repository
//   sl.registerLazySingleton<SuggestionsRepo>(() => SuggestionsRepoImpl(
//       localDataSource: sl(), networkInfo: sl(), remoteDataSource: sl()));

// // Datasources
//   sl.registerLazySingleton<SuggestionsRemoteDataSource>(
//       () => SuggestionsRemoteDataSourceImplWithHttp(client: sl()));

// //? ========================================

// //! Core

//   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

// //? ========================================

// //! External

//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   sl.registerLazySingleton<SharedPreferences>(() => pref);
//   sl.registerLazySingleton(() => http.Client());
// sl.registerLazySingleton(() => InternetConnectionChecker());
}
