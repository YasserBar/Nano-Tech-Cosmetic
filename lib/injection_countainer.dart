import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nano_tech_cosmetic/core/helpers/network_info.dart';
import 'package:nano_tech_cosmetic/features/ad/data/data_sources/Ad_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/ad/data/repository/ad_repo_impl.dart';
import 'package:nano_tech_cosmetic/features/ad/domain/repository/ad_repo.dart';
import 'package:nano_tech_cosmetic/features/ad/domain/usecases/displayAds_usecase.dart';
import 'package:nano_tech_cosmetic/features/ad/presentation/bloc/ad_bloc.dart';
import 'package:nano_tech_cosmetic/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:nano_tech_cosmetic/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/auth/data/repository/auth_repo_impl.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/login_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/logout_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/register_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/resendOTP_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/resetPassword_usecase.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/usecases/verifyOTP_uasecase.dart';
import 'package:nano_tech_cosmetic/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nano_tech_cosmetic/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:nano_tech_cosmetic/features/cart/data/repository/cart_repo_impl.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/repository/cart_repo.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/add_item_cart_usecase.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/delete_item_cart.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/display_cart_usecase.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:nano_tech_cosmetic/features/category/data/data_sources/category_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/category/data/repository/category_repo_impl.dart';
import 'package:nano_tech_cosmetic/features/category/domain/repository/category_repo.dart';
import 'package:nano_tech_cosmetic/features/category/domain/usecases/showAllCategory_usecase.dart';
import 'package:nano_tech_cosmetic/features/category/presentation/bloc/category_bloc.dart';
import 'package:nano_tech_cosmetic/features/offer/data/data_sources/offer_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/offer/data/repository/offer_repo_impl.dart';
import 'package:nano_tech_cosmetic/features/offer/domain/repository/offer_repo.dart';
import 'package:nano_tech_cosmetic/features/offer/domain/usecases/show_offers_usecase.dart';
import 'package:nano_tech_cosmetic/features/offer/presentation/bloc/offer_bloc.dart';
import 'package:nano_tech_cosmetic/features/prodect/data/data_sources/product_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/prodect/data/repository/product_repo_impl.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/repository/product_repo.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/usecases/rate_product_usecase.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/usecases/show_all_product_usecase.dart';
import 'package:nano_tech_cosmetic/features/prodect/presentation/bloc/product_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
// //? Features ================================

//! Feature - Ad
// Bloc
  sl.registerFactory(() => AdBloc(displayAdsUsecase: sl()));

// Usecases
  sl.registerLazySingleton(() => DisplayAdsUsecase(sl()));

// Repository
  sl.registerLazySingleton<AdRepo>(() =>
      AdRepoImpl(remoteDataSource: sl(), authRepo: sl(), networkInfo: sl()));

// Datasources
  sl.registerLazySingleton<AdRemoteDataSource>(
      () => AdRemoteDataSourceImplWithHttp(client: sl()));

//! Feature - auth
// Bloc
  sl.registerFactory(() => AuthBloc(
        loginUsecase: sl(),
        logoutUsecase: sl(),
        registerUsecase: sl(),
        resendOTPUsecase: sl(),
        resetPasswordUsecase: sl(),
        verifyOTPUsecase: sl(),
      ));

// Usecases
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => ResendOTPUsecase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => VerifyOTPUsecase(sl()));

// Repository
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplWithHttp(client: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImplWithSharedPreferences(pref: sl()));

//! Feature - cart
// Bloc
  sl.registerFactory(() => CartBloc(
      addItemCartUsecase: sl(),
      deleteItemCartUsecase: sl(),
      displayCartUsecase: sl()));

// Usecases
  sl.registerLazySingleton(() => DisplayCartUsecase(sl()));
  sl.registerLazySingleton(() => AddItemCartUsecase(sl()));
  sl.registerLazySingleton(() => DeleteItemCartUsecase(sl()));

// Repository
  sl.registerLazySingleton<CartRepo>(
      () => CartRepoImpl(localDataSource: sl(), networkInfo: sl()));

// Datasources
  sl.registerLazySingleton<CartLocalDataSource>(
      () => CartLocalDataSourceImplWithHttp(pref: sl()));

//! Feature - category
// Bloc
  sl.registerFactory(() => CategoryBloc(showAllCategoryUsecase: sl()));

// Usecases
  sl.registerLazySingleton(() => ShowAllCategoryUsecase(sl()));

// Repository
  sl.registerLazySingleton<CategoryRepo>(() => CategoryRepoImpl(
      remoteDataSource: sl(), authRepo: sl(), networkInfo: sl()));

// Datasources
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImplWithHttp(client: sl()));

//! Feature - offer
// Bloc
  sl.registerFactory(() => OfferBloc(showOffersUsecase: sl()));

// Usecases
  sl.registerLazySingleton(() => ShowOffersUsecase(sl()));

// Repository
  sl.registerLazySingleton<OfferRepo>(() =>
      OfferRepoImpl(remoteDataSource: sl(), authRepo: sl(), networkInfo: sl()));

// Datasources
  sl.registerLazySingleton<OfferRemoteDataSource>(
      () => OfferRemoteDataSourceImplWithHttp(client: sl()));

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

//! Feature - prodect
// Bloc
  sl.registerFactory(
      () => ProductBloc(rateProductUsecase: sl(), showAllProductUsecase: sl()));

// Usecases
  sl.registerLazySingleton(() => RateProductUsecase(sl()));
  sl.registerLazySingleton(() => ShowAllProductUsecase(sl()));

// Repository
  sl.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(
      authRepo: sl(), networkInfo: sl(), remoteDataSource: sl()));

// Datasources
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImplWithHttp(client: sl()));

//? ========================================

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//? ========================================

//! External

  final SharedPreferences pref = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => pref);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
