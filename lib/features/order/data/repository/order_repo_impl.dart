// import 'package:dartz/dartz.dart';
// import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
// import 'package:nano_tech_cosmetic/core/errors/failures.dart';
// import 'package:nano_tech_cosmetic/core/helpers/network_info.dart';
// import 'package:nano_tech_cosmetic/core/helpers/switch_exceptions.dart';
// import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';
// import 'package:nano_tech_cosmetic/features/offer/data/data_sources/offer_remote_data_source.dart';
// import 'package:nano_tech_cosmetic/features/offer/data/models/offer_model.dart';
// import 'package:nano_tech_cosmetic/features/offer/domain/repository/offer_repo.dart';

// class OfferRepoImpl extends OfferRepo {
//   final OfferRemoteDataSource remoteDataSource;
//   final AuthRepo authRepo;
//   final NetworkInfo networkInfo;

//   OfferRepoImpl({
//     required this.remoteDataSource,
//     required this.authRepo,
//     required this.networkInfo,
//   });

//   @override
//   Future<Either<Failure, List<OfferModel>>> showOffers(int page,
//       {int? productId}) async {
//     if (await networkInfo.isConnected) {
//       try {
//         final List<OfferModel> offers =
//             await remoteDataSource.showOffers(page, productId: productId);
//         return Right(offers);
//       } on UnauthorizedException {
//         final Either<Failure, Unit> either = await authRepo.refreshToken();
//         return either.fold(
//           (failure) => Left(failure),
//           (unit) async {
//             try {
//               final List<OfferModel> offers =
//                   await remoteDataSource.showOffers(page, productId: productId);
//               return Right(offers);
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
