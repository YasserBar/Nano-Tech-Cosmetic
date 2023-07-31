// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:nano_tech_cosmetic/core/constants/app_routes.dart';
// import 'package:nano_tech_cosmetic/core/helpers/header.dart';
// import 'package:nano_tech_cosmetic/core/helpers/switch_status_code.dart';
// import 'package:nano_tech_cosmetic/features/offer/data/models/offer_model.dart';
// import 'package:nano_tech_cosmetic/main.dart';

// abstract class OfferRemoteDataSource {
//   Future<List<OfferModel>> showOffers(int page, {int? productId});
// }

// class OfferRemoteDataSourceImplWithHttp extends OfferRemoteDataSource {
//   final http.Client client;

//   OfferRemoteDataSourceImplWithHttp({required this.client});

//   @override
//   Future<List<OfferModel>> showOffers(int page, {int? productId}) async {
//     final response = await client.get(
//         Uri.parse(AppRoutes.baseUrl + AppRoutes.showOffers).replace(
//             queryParameters: {"page": page, "product_id": productId}
//                 .map((key, value) => MapEntry(key, value.toString()))),
//         headers: setHeadersWithTokenAndLang());
//     try {
//       final bodyJson = json.decode(response.body);
//       globalMessage = bodyJson['message'];
//       switchStatusCode(response);
//       final dataJson = bodyJson["data"]["data"];
//       final List<OfferModel> listOfferModel = dataJson
//           .map<OfferModel>(
//               (jsonOfferModel) => OfferModel.fromJson(jsonOfferModel))
//           .toList();
//       return Future.value(listOfferModel);
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
