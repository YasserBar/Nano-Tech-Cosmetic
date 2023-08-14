import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/main.dart';

setHeadersWithToken({String? token}) => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? globalUser!.token}',
      'lang': Get.locale!.languageCode.toString(),
    };
setHeaders() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'lang': Get.locale!.languageCode.toString(),
    };
