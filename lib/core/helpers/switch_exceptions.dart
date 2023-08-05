import 'package:nano_tech_cosmetic/core/errors/exception.dart';
import 'package:nano_tech_cosmetic/core/errors/failures.dart';

Failure switchException(Object exception) {
  if (exception is BadRequestException) {
    return BadRequestFailure();
  } else if (exception is ForbiddenException) {
    return ForbiddenFailure();
  } else if (exception is NotFoundException) {
    return NotFoundFailure();
  } else if (exception is EmptyCacheException) {
    return EmptyCacheFailure();
  } else if (exception is InternalServerErrorException) {
    return InternalServerErrorFailure();
  } else {
    // print(exception);
    return UnexpectedFailure();
  }
}
