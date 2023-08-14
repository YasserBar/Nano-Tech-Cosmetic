import 'package:nano_tech_cosmetic/main.dart';

setHeadersWithToken({String? token}) => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? globalUser!.token}',
      'lang': 'ar',
    };
setHeaders() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'lang': 'ar',
    };
