import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nano_tech_cosmetic/core/constants/app_routes.dart';
import 'package:nano_tech_cosmetic/features/ad/data/models/ad_model.dart';
import 'package:nano_tech_cosmetic/features/ad/domain/entities/ad_entity.dart';
import 'package:nano_tech_cosmetic/core/helpers/header.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_status_code.dart';
import 'package:nano_tech_cosmetic/main.dart';

abstract class AdRemoteDataSource {
  Future<List<Ad>> displayAds(int page);
}

class AdRemoteDataSourceImplWithHttp extends AdRemoteDataSource {
  final http.Client client;

  AdRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<List<Ad>> displayAds(int page) async {
    final response = await client.get(
        Uri.parse(AppRoutes.baseUrl + AppRoutes.displayAds).replace(
            queryParameters: {"page": page}
                .map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithTokenAndLang());
    try {
      final bodyJson = json.decode(response.body);
      globalMessage = bodyJson['message'];
      switchStatusCode(response);
      final dataJson = bodyJson["data"]["data"];
      final List<AdModel> listAdModel = dataJson
          .map<AdModel>((jsonAdModel) => AdModel.fromJson(jsonAdModel))
          .toList();
      return Future.value(listAdModel);
    } catch (e) {
      rethrow;
    }
  }
}
