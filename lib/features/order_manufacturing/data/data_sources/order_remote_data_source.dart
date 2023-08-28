import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:nano_tech_cosmetic/core/constants/app_routes.dart';
import 'package:nano_tech_cosmetic/core/helpers/header.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_status_code.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/data/models/order_manufacturing_model.dart';
import 'package:nano_tech_cosmetic/features/order_manufacturing/data/models/request_order_manufacturing_model.dart';
import 'package:nano_tech_cosmetic/main.dart';

abstract class OrderManufacturingRemoteDataSource {
  Future<List<OrderManufacturingModel>> displayOrdersManufacturing(
      {required int page, int? status});

  Future<Unit> addOrderManufacturing(
      {required RequestOrderManufacturingModel requestOrderManufacturingModel});
}

class OrderManufacturingRemoteDataSourceImplWithHttp
    extends OrderManufacturingRemoteDataSource {
  final http.Client client;

  OrderManufacturingRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<List<OrderManufacturingModel>> displayOrdersManufacturing(
      {required int page, int? status}) async {
    final response = await client.get(
        Uri.parse(AppRoutes.baseUrl + AppRoutes.displayOrderManufacturing)
            .replace(
                queryParameters: {"page": page, "state": status}
                    .map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken());
    try {
      final bodyJson = json.decode(response.body);
      globalMessage = bodyJson['message'];
      switchStatusCode(response);
      final dataJson = bodyJson["order"]["data"];
      final List<OrderManufacturingModel> listOrderManufacturingModel = dataJson
          .map<OrderManufacturingModel>((jsonOrderManufacturingModel) =>
              OrderManufacturingModel.fromJson(jsonOrderManufacturingModel))
          .toList();
      return Future.value(listOrderManufacturingModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> addOrderManufacturing(
      {required RequestOrderManufacturingModel
          requestOrderManufacturingModel}) async {
    final response = await client.post(
      Uri.parse(AppRoutes.baseUrl + AppRoutes.addOrderManufacturing),
      body: json.encode(requestOrderManufacturingModel.toJson()),
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
