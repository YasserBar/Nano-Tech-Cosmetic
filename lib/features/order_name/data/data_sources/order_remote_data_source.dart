import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:nano_tech_cosmetic/core/constants/app_routes.dart';
import 'package:nano_tech_cosmetic/core/helpers/header.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_status_code.dart';
import 'package:nano_tech_cosmetic/features/order_name/data/models/order_model.dart';
import 'package:nano_tech_cosmetic/features/order_name/data/models/request_order_name_model.dart';
import 'package:nano_tech_cosmetic/main.dart';

abstract class OrderNameRemoteDataSource {
  Future<List<OrderNameModel>> displayOrdersName(
      {required int page, int? status});

  Future<Unit> addOrderName(
      {required RequestOrderNameModel requestOrderNameModel});
}

class OrderNameRemoteDataSourceImplWithHttp extends OrderNameRemoteDataSource {
  final http.Client client;

  OrderNameRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<List<OrderNameModel>> displayOrdersName(
      {required int page, int? status}) async {
    final response = await client.post(
        Uri.parse(AppRoutes.baseUrl + AppRoutes.displayOrderName).replace(
            queryParameters: {"page": page, "state": status}
                .map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken());
    try {
      final bodyJson = json.decode(response.body);
      globalMessage = bodyJson['message'];
      switchStatusCode(response);
      final dataJson = bodyJson["order"]["data"];
      final List<OrderNameModel> listOrderNameModel = dataJson
          .map<OrderNameModel>((jsonOrderNameModel) =>
              OrderNameModel.fromJson(jsonOrderNameModel))
          .toList();
      return Future.value(listOrderNameModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> addOrderName(
      {required RequestOrderNameModel requestOrderNameModel}) async {
    final response = await client.post(
      Uri.parse(AppRoutes.baseUrl + AppRoutes.addOrderName),
      body: json.encode(requestOrderNameModel.toJson()),
      headers: setHeadersWithToken(),
    );
    try {
      final bodyJson = json.decode(response.body);
      globalMessage = bodyJson['message'];
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }
}
