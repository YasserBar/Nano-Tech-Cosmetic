import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/main.dart';

setHeadersWithToken({String? token}) => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? globalUser!.token}',
      'lang': Get.deviceLocale!.languageCode,
    };
setHeaders() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'lang': Get.deviceLocale!.languageCode,
    };
