// import 'package:dartz/dartz.dart';
// import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
// import 'package:nano_tech_cosmetic/core/errors/failures.dart';
// import 'package:nano_tech_cosmetic/core/helpers/network_info.dart';
// import 'package:nano_tech_cosmetic/core/helpers/switch_exceptions.dart';
// import 'package:nano_tech_cosmetic/features/cart/data/data_sources/cart_local_data_source.dart';
// import 'package:nano_tech_cosmetic/features/category/data/models/category_model.dart';
// import 'package:nano_tech_cosmetic/features/category/domain/repository/category_repo.dart';

// class CartRepoImpl extends CategoryRepo {
//   final CartLocalDataSource localDataSource;
//   final NetworkInfo networkInfo;

//   CartRepoImpl({
//     required this.localDataSource,
//     required this.networkInfo,
//   });

//   @override
//   Future<Either<Failure, List<CategoryModel>>> showAllCategory(int page) async {
//     if (await networkInfo.isConnected) {
//       try {
//         final List<CategoryModel> categories =
//             await localDataSource.showAllCategory(page);
//         return Right(categories);
//       } on UnauthorizedException {
//         final Either<Failure, Unit> either = await authRepo.refreshToken();
//         return either.fold(
//           (failure) => Left(failure),
//           (unit) async {
//             try {
//               final List<CategoryModel> categories =
//                   await localDataSource.showAllCategory(page);
//               return Right(categories);
//             } on UnauthorizedException {
//               return Left(UnauthorizedFailure());
//             } catch (e) {
//               return Left(switchException(e));
//             }
//           },
//         );
//       } catch (e) {
//         return Left(switchException(e));
//       }
//     } else {
//       return Left(OfflineFailure());
//     }
//   }
// }
