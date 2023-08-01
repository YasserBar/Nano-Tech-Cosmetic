import 'package:dartz/dartz.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/core/helpers/network_info.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_exceptions.dart';
import 'package:nano_tech_cosmetic/features/ad/data/data_sources/Ad_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/ad/data/models/ad_model.dart';
import 'package:nano_tech_cosmetic/features/ad/domain/repository/ad_repo.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';

class AdRepoImpl extends AdRepo {
  final AdRemoteDataSource remoteDataSource;
  final AuthRepo authRepo;
  final NetworkInfo networkInfo;

  AdRepoImpl({
    required this.remoteDataSource,
    required this.authRepo,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<AdModel>>> displayAds(int page) async {
    if (!await networkInfo.isConnected) {
      try {
        final List<AdModel> ads = await remoteDataSource.displayAds(page);
        return Right(ads);
      } on UnauthorizedException {
        final Either<Failure, Unit> either = await authRepo.refreshToken();
        return either.fold(
          (failure) => Left(failure),
          (unit) async {
            try {
              final List<AdModel> ads = await remoteDataSource.displayAds(page);
              return Right(ads);
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
}
