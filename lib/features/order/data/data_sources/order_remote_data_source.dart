import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nano_tech_cosmetic/core/constants/app_routes.dart';
import 'package:nano_tech_cosmetic/core/helpers/header.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_status_code.dart';
import 'package:nano_tech_cosmetic/features/order/data/models/order_details_model.dart';
import 'package:nano_tech_cosmetic/features/order/data/models/order_model.dart';
import 'package:nano_tech_cosmetic/features/order/data/models/request_order_model.dart';
import 'package:nano_tech_cosmetic/main.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> displayOrders({required int page, int? status});

  Future<OrderDetailsModel> displayOrderDetails(
      {required int page, required int orderId});

  Future<Unit> storeOrder({required RequestOrderModel requestOrderModel});
}

class OrderRemoteDataSourceImplWithHttp extends OrderRemoteDataSource {
  final http.Client client;

  OrderRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<List<OrderModel>> displayOrders(
      {required int page, int? status}) async {
    final response = await client.get(
        Uri.parse(AppRoutes.baseUrl + AppRoutes.displayOrder).replace(
            queryParameters: {"page": page, "status": status}
                .map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken());
    try {
      final bodyJson = json.decode(response.body);
      globalMessage = bodyJson['message'];
      switchStatusCode(response);
      final dataJson = bodyJson["order"];
      if (kDebugMode) {
        print("step 1========= $bodyJson");
      }
      final List<OrderModel> listOrderModel = dataJson
          .map<OrderModel>(
              (jsonOrderModel) => OrderModel.fromJson(jsonOrderModel))
          .toList();
      if (kDebugMode) {
        print("step 2========= $listOrderModel");
      }
      return Future.value(listOrderModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> storeOrder(
      {required RequestOrderModel requestOrderModel}) async {
    final response = await client.post(
      Uri.parse(AppRoutes.baseUrl + AppRoutes.storeOrder),
      body: json.encode(requestOrderModel.toJson()),
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

  @override
  Future<OrderDetailsModel> displayOrderDetails(
      {required int page, required int orderId}) async {
    final response = await client.post(
        Uri.parse(AppRoutes.baseUrl + AppRoutes.displayOrderDetails).replace(
            queryParameters: {
          "page": page,
          "orderId": orderId,
        }.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken());
    try {
      final bodyJson = json.decode(response.body);
      globalMessage = bodyJson['message'];
      switchStatusCode(response);
      final OrderDetailsModel orderDetailsModel =
          OrderDetailsModel.fromJson(bodyJson);
      return Future.value(orderDetailsModel);
    } catch (e) {
      rethrow;
    }
  }
}
