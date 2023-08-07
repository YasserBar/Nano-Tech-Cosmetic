import 'package:dartz/dartz.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';
import 'package:nano_tech_cosmetic/core/helpers/network_info.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_exceptions.dart';
import 'package:nano_tech_cosmetic/features/auth/domain/repository/auth_repo.dart';
import 'package:nano_tech_cosmetic/features/category/data/data_sources/category_remote_data_source.dart';
import 'package:nano_tech_cosmetic/features/category/data/models/category_model.dart';
import 'package:nano_tech_cosmetic/features/category/domain/repository/category_repo.dart';

class CategoryRepoImpl extends CategoryRepo {
  final CategoryRemoteDataSource remoteDataSource;
  final AuthRepo authRepo;
  final NetworkInfo networkInfo;

  CategoryRepoImpl({
    required this.remoteDataSource,
    required this.authRepo,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CategoryModel>>> showAllCategory(int page,
      {String? name}) async {
    if (await networkInfo.isConnected) {
      try {
        final List<CategoryModel> categories =
            await remoteDataSource.showAllCategory(page, name: name);
        return Right(categories);
      } on UnauthorizedException {
        final Either<Failure, Unit> either = await authRepo.refreshToken();
        return either.fold(
          (failure) => Left(failure),
          (unit) async {
            try {
              final List<CategoryModel> categories =
                  await remoteDataSource.showAllCategory(page);
              return Right(categories);
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
