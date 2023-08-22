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
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/decrease_item_cart.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/delete_cart.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/delete_item_cart.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/display_cart_usecase.dart';
import 'package:nano_tech_cosmetic/features/cart/domain/usecases/increase_item_cart.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:nano_tech_cosmetic/features/cart/presentation/bloc/item_cart_bloc/item_cart_bloc.dart';
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
import 'package:nano_tech_cosmetic/features/order/data/data_sources/order_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/order/data/repository/order_repo_impl.dart';
import 'package:nano_tech_cosmetic/features/order/domain/repository/order_repo.dart';
import 'package:nano_tech_cosmetic/features/order/domain/usecases/display_order_details_usecase.dart';
import 'package:nano_tech_cosmetic/features/order/domain/usecases/display_orders_usecase.dart';
import 'package:nano_tech_cosmetic/features/order/domain/usecases/store_order_usecase.dart';
import 'package:nano_tech_cosmetic/features/order/presentation/bloc/order_bloc.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/data/data_sources/order_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/data/repository/order_repo_impl.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/repository/order_manufacturing_repo.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/usecases/add_order_manufacturing_usecase.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/domain/usecases/display_orders_manufacturing_usecase.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/presentation/bloc/order_manufacturing_bloc.dart';
import 'package:nano_tech_cosmetic/features/order_name/data/data_sources/order_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/order_name/data/repository/order_repo_impl.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/repository/order_repo.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/usecases/add_order_name_usecase.dart';
import 'package:nano_tech_cosmetic/features/order_name/domain/usecases/display_orders_name_usecase.dart';
import 'package:nano_tech_cosmetic/features/order_name/presentation/bloc/order_name_bloc.dart';
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
  sl.registerFactory(
    () => CartBloc(
      addItemCartUsecase: sl(),
      displayCartUsecase: sl(),
      deleteCartUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => ItemCartBloc(
      deleteItemCartUsecase: sl(),
      increaseItemCartUsecase: sl(),
      decreaseItemCartUsecase: sl(),
    ),
  );

// Usecases
  sl.registerLazySingleton(() => DisplayCartUsecase(sl()));
  sl.registerLazySingleton(() => AddItemCartUsecase(sl()));
  sl.registerLazySingleton(() => DeleteItemCartUsecase(sl()));
  sl.registerLazySingleton(() => IncreaseItemCartUsecase(sl()));
  sl.registerLazySingleton(() => DecreaseItemCartUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCartUsecase(sl()));

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
// Bloc
  sl.registerFactory(() => OrderBloc(
        displayOrderDetailsUsecase: sl(),
        displayOrdersUsecase: sl(),
        storeOrderUsecase: sl(),
      ));

// // Usecases
  sl.registerLazySingleton(() => DisplayOrderDetailsUsecase(sl()));
  sl.registerLazySingleton(() => DisplayOrdersUsecase(sl()));
  sl.registerLazySingleton(() => StoreOrderUsecase(sl()));

// Repository
  sl.registerLazySingleton<OrderRepo>(() => OrderRepoImpl(
        authRepo: sl(),
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));

// Datasources
  sl.registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImplWithHttp(client: sl()));

// //! Feature - Order Manufacturing
// Bloc
  sl.registerFactory(() => OrderManufacturingBloc(
        addOrderManufacturingUsecase: sl(),
        displayOrdersManufacturingUsecase: sl(),
      ));

// // Usecases
  sl.registerLazySingleton(() => AddOrderManufacturingUsecase(sl()));
  sl.registerLazySingleton(() => DisplayOrdersManufacturingUsecase(sl()));

// Repository
  sl.registerLazySingleton<OrderManufacturingRepo>(
      () => OrderManufacturingRepoImpl(
            authRepo: sl(),
            networkInfo: sl(),
            remoteDataSource: sl(),
          ));

// Datasources
  sl.registerLazySingleton<OrderManufacturingRemoteDataSource>(
      () => OrderManufacturingRemoteDataSourceImplWithHttp(client: sl()));

// //! Feature - Order Name
// Bloc
  sl.registerFactory(() => OrderNameBloc(
        addOrderNameUsecase: sl(),
        displayOrdersNameUsecase: sl(),
      ));

// // Usecases
  sl.registerLazySingleton(() => AddOrderNameUsecase(sl()));
  sl.registerLazySingleton(() => DisplayOrdersNameUsecase(sl()));

// Repository
  sl.registerLazySingleton<OrderNameRepo>(() => OrderNameRepoImpl(
        authRepo: sl(),
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));

// Datasources
  sl.registerLazySingleton<OrderNameRemoteDataSource>(
      () => OrderNameRemoteDataSourceImplWithHttp(client: sl()));

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
