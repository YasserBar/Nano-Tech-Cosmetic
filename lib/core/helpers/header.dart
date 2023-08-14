import 'package:get/get.dart';
import 'package:nano_tech_cosmetic/core/localization/local_controller.dart';
import 'package:nano_tech_cosmetic/main.dart';

LocaleController controller = Get.put(LocaleController());

setHeadersWithToken({String? token}) => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? globalUser!.token}',
      'lang': controller.language.toString(),
    };
setHeaders() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'lang': controller.language.toString(),
    };
