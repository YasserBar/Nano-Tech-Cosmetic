import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:nano_tech_cosmetic/core/constants/app_routes.dart';
import 'package:nano_tech_cosmetic/core/constants/enum_roll.dart';
import 'package:nano_tech_cosmetic/core/helpers/header.dart';
import 'package:nano_tech_cosmetic/core/helpers/switch_status_code.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/auth_model.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/login_model.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/register_model.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/resend_otp_model.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/reset_password_model.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/user_model.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/verify_otp_model.dart';
import 'package:nano_tech_cosmetic/main.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(LoginModel login);

  Future<Unit> logout();

  Future<Unit> register(RegisterModel registerModel, Roll roll);

  Future<Unit> resetPassword(ResetPasswordModel resetPasswordModel);

  Future<Unit> resendOTP(ResendOTPModel resendOTPModel);

  Future<AuthModel> refreshToken();

  Future<UserModel> verifyOTP(VerifyOTPModel verifyOTPModel);
}

class AuthRemoteDataSourceImplWithHttp extends AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<UserModel> login(LoginModel login) async {
    final response = await client.post(
      Uri.parse(AppRoutes.baseUrl + AppRoutes.login),
      body: json.encode(login.toJson()),
      headers: setHeaders(),
    );
    try {
      final bodyJson = json.decode(response.body);
      print('step 1    ');
      globalMessage = bodyJson['message'];
      print('step 2    ');
      switchStatusCode(response);
      print('step 3    ');
      final UserModel userModel = UserModel.fromJson(bodyJson);
      print('step 4    ');
      return Future.value(userModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> logout() async {
    final response = await client.get(
        Uri.parse(AppRoutes.baseUrl + AppRoutes.logout),
        headers: setHeadersWithToken());
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
  Future<Unit> resetPassword(ResetPasswordModel resetPasswordModel) async {
    final response = await client.post(
        Uri.parse(AppRoutes.baseUrl + AppRoutes.resetPassword),
        body: json.encode(resetPasswordModel.toJson()),
        headers: setHeadersWithToken());
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
  Future<Unit> resendOTP(ResendOTPModel resendOTPModel) async {
    final response = await client.post(
        Uri.parse(AppRoutes.baseUrl + AppRoutes.resendotp),
        body: json.encode(resendOTPModel.toJson()),
        headers: setHeaders());
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
  Future<Unit> register(RegisterModel registerModel, Roll roll) async {
    final String rootRegister ;
    switch (roll) {
      case Roll.customer:
        rootRegister = AppRoutes.registerUser;
        break;
      case Roll.salon:
        rootRegister = AppRoutes.registerSalon;
        break;
      case Roll.company:
        rootRegister = AppRoutes.registerCompany;
        break;
      case Roll.guest:
        rootRegister = AppRoutes.registerCompany;
        break;
    }

    final response = await client.post(
        Uri.parse(AppRoutes.baseUrl + rootRegister),
        body: json.encode(registerModel.toJson()),
        headers: setHeaders());
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
  Future<UserModel> verifyOTP(VerifyOTPModel verifyOTPModel) async {
    final response = await client.post(
        Uri.parse(AppRoutes.baseUrl + AppRoutes.verifyOtp),
        body: json.encode(verifyOTPModel.toJson()),
        headers: setHeaders());
    try {
      final bodyJson = json.decode(response.body);
      globalMessage = bodyJson['message'];
      switchStatusCode(response);
      final UserModel userModel = UserModel.fromJson(bodyJson);
      return Future.value(userModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthModel> refreshToken() async {
    final response = await client.get(
        Uri.parse(AppRoutes.baseUrl + AppRoutes.refreshToken),
        headers: setHeadersWithToken()); //!TODO==================refreshToken
    try {
      final bodyJson = json.decode(response.body);
      globalMessage = bodyJson['message']; //TODO=================Message
      switchStatusCode(response);
      final AuthModel authModel = AuthModel.fromJson(bodyJson["data"]);
      return Future.value(authModel);
    } catch (e) {
      rethrow;
    }
  }
}
