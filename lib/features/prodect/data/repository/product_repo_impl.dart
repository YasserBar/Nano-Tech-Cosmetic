import 'package:dartz/dartz.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/core/helpers/network_info.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_exceptions.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';
import 'package:nano_tech_cosmetic/features/prodect/data/data_sources/product_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/prodect/data/models/product_model.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/repository/product_repo.dart';

class ProductRepoImpl extends ProductRepo {
  final ProductRemoteDataSource remoteDataSource;
  final AuthRepo authRepo;
  final NetworkInfo networkInfo;

  ProductRepoImpl({
    required this.remoteDataSource,
    required this.authRepo,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> rateProduct(int rate, int prodectId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.rateProduct(rate, prodectId);
        return const Right(unit);
      } on UnauthorizedException {
        final Either<Failure, Unit> either = await authRepo.refreshToken();
        return either.fold(
          (failure) => Left(failure),
          (done) async {
            try {
              await remoteDataSource.rateProduct(rate, prodectId);
              return const Right(unit);
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
  Future<Either<Failure, List<ProductModel>>> showAllProduct(int page,
      {int? categoryId, String? name}) async {
    if (await networkInfo.isConnected) {
      try {
        final List<ProductModel> products = await remoteDataSource
            .showAllProduct(page, categoryId: categoryId, name: name);
        return Right(products);
      } on UnauthorizedException {
        final Either<Failure, Unit> either = await authRepo.refreshToken();
        return either.fold(
          (failure) => Left(failure),
          (unit) async {
            try {
              final List<ProductModel> products = await remoteDataSource
                  .showAllProduct(page, categoryId: categoryId, name: name);
              return Right(products);
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
