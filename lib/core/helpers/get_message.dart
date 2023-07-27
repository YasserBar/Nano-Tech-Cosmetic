// import 'package:dartz/dartz.dart';
// import '../../../../core/helpers/network_info.dart';
// import '../../features/auth/data/datasources/auth_local_data_source.dart';
// import '../../features/auth/data/models/response_auth_model.dart';
// import '../../main.dart';
// import '../errors/exception.dart';
// import '../errors/failures.dart';

// typedef GetMessage = Future<Unit> Function();

// Future<Either<Failure, Unit>> getMessage(
//     GetMessage common, NetworkInfo networkInfo,
//     {bool? isLogout, AuthLocalDataSource? localDataSource}) async {
//   return performRequest<Unit>(common, networkInfo);
// }

// Future<Either<Failure, T>> performRequest<T>(
//   Function func,
//   NetworkInfo networkInfo, {
//   bool? remmberMe,
//   AuthLocalDataSource? localDataSource,
//   bool? isLogout,
// }) async {
//   if (await networkInfo.isConnected) {
//     try {
//       final response = await func();
//       if (isLogout == null) {
//         if (remmberMe != null && remmberMe) {
//           ResponseAuthModel tempResponse = response;
//           token = tempResponse.token;
//           await localDataSource!.cacheResponse(response);
//           // ResponseAuth t = await localDataSource.getCachedResponse();
//           // print("${t.token}7777777777777777777777777");
//         } else if (remmberMe != null && !remmberMe) {
//           ResponseAuthModel tempResponse = response;
//           token = tempResponse.token;
//         }
//       } else {
//         localDataSource!.removeCachedResponse();
//         token = null;
//       }
//       return Right(response);
//     } on BadRequestException {
//       return Left(BadRequestFailure());
//     } on UnauthorizedException {
//       return Left(UnauthorizedFailure());
//     } on ForbiddenException {
//       return Left(ForbiddenFailure());
//     } on NotFoundException {
//       return Left(NotFoundFailure());
//     } on InternalServerErrorException {
//       return Left(InternalServerErrorFailure());
//     } on WrongDataException {
//       return Left(WrongDataFailure());
//     }
//   } else {
//     return Left(OfflineFailure());
//   }
// }
