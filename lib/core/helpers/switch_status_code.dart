import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../errors/exception.dart';

Unit switchStatusCode(Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      return unit;
    case 400:
      throw BadRequestException();
    case 401:
      throw UnauthorizedException();
    case 403:
      throw ForbiddenException();
    case 404:
      throw NotFoundException();
    case 500:
      throw InternalServerErrorException();
    default:
      throw UnexpectedException();
  }
}
