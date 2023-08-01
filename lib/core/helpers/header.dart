import 'package:nano_tech_cosmetic/main.dart';

setHeadersWithTokenAndLang() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer ${globalUser!.token}',
      // 'lang': 'ar',//TODO===========lang
    };
setHeadersWithToken() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${globalUser!.token}',
    };
setHeaders() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
