import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:nano_tech_cosmetic/core/constants/app_routes.dart';
import 'package:nano_tech_cosmetic/core/helpers/header.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_status_code.dart';
import 'package:nano_tech_cosmetic/features/prodect/data/models/product_model.dart';
import 'package:nano_tech_cosmetic/features/prodect/domain/entities/rate_product_entity.dart';
import 'package:nano_tech_cosmetic/main.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> showAllProduct(int page,
      {int? categoryId, String? name});

  Future<Unit> rateProduct(RateProduct rateProduct);
}

class ProductRemoteDataSourceImplWithHttp extends ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<Unit> rateProduct(RateProduct rateProduct) async {
    final response = await client.post(
        Uri.parse(AppRoutes.baseUrl + AppRoutes.rateProduct).replace(
            queryParameters: {"product_id": rateProduct.productId, "rating": rateProduct.rate}
                .map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithTokenAndLang());
    try {
      final bodyJson = json.decode(response.body);
      globalMessage = bodyJson['message'];
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> showAllProduct(int page,
      {int? categoryId, String? name}) async {
    final response = await client.get(
        Uri.parse(AppRoutes.baseUrl + AppRoutes.showAllProduct).replace(
            queryParameters: {
          "page": page,
          "category_id": categoryId,
          "name": name
        }.map((key, value) =>
                MapEntry(key, value == null ? '' : value.toString()))),
        headers: setHeadersWithTokenAndLang());
    // print(response.body);
    try {
      final bodyJson = json.decode(response.body);
      globalMessage = bodyJson['message'];
      switchStatusCode(response);
      final dataJson = bodyJson["data"]["data"];
      final List<ProductModel> listProductModel = dataJson
          .map<ProductModel>(
              (jsonProductModel) => ProductModel.fromJson(jsonProductModel))
          .toList();
      return Future.value(listProductModel);
    } catch (e) {
      rethrow;
    }
  }

}
