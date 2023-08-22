import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nano_tech_cosmetic/core/constants/app_routes.dart';
import 'package:nano_tech_cosmetic/core/helpers/header.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_status_code.dart';
import 'package:nano_tech_cosmetic/features/category/data/models/category_model.dart';
import 'package:nano_tech_cosmetic/main.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> showAllCategory(int page, {String? name});
}

class CategoryRemoteDataSourceImplWithHttp extends CategoryRemoteDataSource {
  final http.Client client;

  CategoryRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<List<CategoryModel>> showAllCategory(int page, {String? name}) async {
    final response = await client.get(
        Uri.parse(AppRoutes.baseUrl + AppRoutes.showAllCategory).replace(
            queryParameters: {"page": page, "name": name}
                .map((key, value) => MapEntry(key,  value == null ? '' : value.toString()))),
        headers: setHeaders());
    try {
      final bodyJson = json.decode(response.body);
      globalMessage = bodyJson['message'];
      switchStatusCode(response);
      final dataJson = bodyJson["data"]["data"];
      final List<CategoryModel> listCategoryModel = dataJson
          .map<CategoryModel>(
              (jsonCategoryModel) => CategoryModel.fromJson(jsonCategoryModel))
          .toList();
      return Future.value(listCategoryModel);
    } catch (e) {
      rethrow;
    }
  }
}
