// import 'package:dartz/dartz.dart';
// import '../../features/auth/data/datasources/auth_local_data_source.dart';
// import '../../main.dart';
// import '../errors/exception.dart';
// import '../errors/failures.dart';
// import '../../injection_countainer.dart' as di;


// Future<Either<Failure, String>> getToken() async {
//   if (token != null) {
//     return Right(token!);
//   }

//   try {
//     final cachedResponseAuth = await di.sl<AuthLocalDataSource>().getCachedResponse();
//     token = cachedResponseAuth.token;
//     return Right(token!);
//   } on EmptyCacheException {
//     return Left(EmptyCacheFailure());
//   }
// }