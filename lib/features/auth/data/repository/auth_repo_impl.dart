import 'package:dartz/dartz.dart';
import 'package:nano_tech_cosmetic/core/constants/app_enums.dart';
import 'package:nano_tech_cosmetic/core/errors/exception.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/core/helpers/network_info.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_exceptions.dart';
import 'package:nano_tech_cosmetic/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:nano_tech_cosmetic/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/auth_model.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/login_model.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/register_model.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/resend_otp_model.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/reset_password_model.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/user_model.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/verify_otp_model.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/login_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/register_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/resend_otp_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/reset_password_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/user_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';
import 'package:nano_tech_cosmetic/main.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(Login login) async {
    final LoginModel loginModel = LoginModel(login.email, login.password);

    if (await networkInfo.isConnected) {


      try {
        final UserModel userModel = await remoteDataSource.login(loginModel);
        // print('out 1    ');
        globalUser = userModel;
        // print('out 2   ');
        localDataSource.cacheUser(userModel);
        // print('out 3   ');
        return Right(userModel);
      } catch (e) {
        return Left(switchException(e));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        Unit unit = await remoteDataSource.logout();
        localDataSource.removeCachedUser();
        return Right(unit);
      } on UnauthorizedException {
        final Either<Failure, Unit> either = await refreshToken();
        return either.fold(
          (failure) => Left(failure),
          (unit) async {
            try {
              unit = await remoteDataSource.logout();
              localDataSource.removeCachedUser();
              return Right(unit);
            } on UnauthorizedException {
              return Left(UnauthorizedFailure());
            } catch (e) {
              return Left(switchException(e));
            }
          },
        );
      } catch (e) {
        return Left(switchException(e));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> register(Register register, Role roll) async {
    final RegisterModel registerModel = RegisterModel(
      register.firstName,
      register.lastName,
      register.gender,
      register.birthday,
      register.address,
      register.phone,
      register.email,
      register.password,
      register.facebook,
      register.twitter,
      register.instagram,
      register.telegram,
    );

    if (await networkInfo.isConnected) {
      try {
        final Unit unit = await remoteDataSource.register(registerModel, roll);
        return Right(unit);
      } catch (e) {
        return Left(switchException(e));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> resendOTP(ResendOTP resendOTP) async {
    final ResendOTPModel registerModel = ResendOTPModel(resendOTP.email);

    if (await networkInfo.isConnected) {
      try {
        final Unit unit = await remoteDataSource.resendOTP(registerModel);
        return Right(unit);
      } catch (e) {
        return Left(switchException(e));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(
      ResetPassword resetPassword) async {
    final ResetPasswordModel resetPasswordModel =
        ResetPasswordModel(resetPassword.password);

    if (await networkInfo.isConnected) {
      try {
        final Unit unit =
            await remoteDataSource.resetPassword(resetPasswordModel);
        return Right(unit);
      } on UnauthorizedException {
        final Either<Failure, Unit> either = await refreshToken();
        return either.fold(
          (failure) => Left(failure),
          (unit) async {
            try {
              unit = await remoteDataSource.logout();
              localDataSource.removeCachedUser();
              return Right(unit);
            } on UnauthorizedException {
              return Left(UnauthorizedFailure());
            } catch (e) {
              return Left(switchException(e));
            }
          },
        );
      } catch (e) {
        return Left(switchException(e));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> verifyOTP(VerifyOTP verifyOTP) async {
    final VerifyOTPModel verifyOTPModel = VerifyOTPModel(verifyOTP.otp);

    if (await networkInfo.isConnected) {
      try {
        final UserModel userModel =
            await remoteDataSource.verifyOTP(verifyOTPModel);
        globalUser = userModel;
        localDataSource.cacheUser(userModel);
        return Right(userModel);
      } catch (e) {
        return Left(switchException(e));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> refreshToken() async {
    if (await networkInfo.isConnected) {
      try {
        final AuthModel authModel = await remoteDataSource.refreshToken();
        UserModel userModel = await localDataSource.getCachedUser();
        userModel.token = authModel.token;
        userModel.refreshToken = authModel.refreshToken;
        localDataSource.cacheUser(userModel);
        return const Right(unit);
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        return Left(switchException(e));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
