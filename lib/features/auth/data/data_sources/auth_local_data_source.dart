import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nano_tech_cosmetic/core/constants/app_keys.dart';
import 'package:nano_tech_cosmetic/core/errors/exception.dart';
import 'package:nano_tech_cosmetic/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<Unit> cacheUser(UserModel userModel);
  Future<UserModel> getCachedUser();
  Future<Unit> removeCachedUser();
  // Future<Unit> cacheAuth(AuthModel authModel);
  // Future<AuthModel> getCachedAuth();
  // Future<Unit> removeCachedAuth();
}

class AuthLocalDataSourceImplWithSharedPreferences extends AuthLocalDataSource {
  final SharedPreferences pref;

  AuthLocalDataSourceImplWithSharedPreferences({
    required this.pref,
  });

  @override
  Future<Unit> cacheUser(UserModel userModel) async {
    Object userJson = userModel.toJson();
    final storeUser =
        await pref.setString(AppKeys.CACHED_USER, userJson.toString());
    if (kDebugMode) {
      if (storeUser) {
        print('store User');
      } else {
        print('failure');
      }
    }
    return Future.value(unit);
  }

  @override
  Future<UserModel> getCachedUser() {
    final String? userString = pref.getString(AppKeys.CACHED_USER);
    if (userString != null) {
      if (kDebugMode) {
        print(userString);
      }
      return Future.value(UserModel.fromJson(json.decode(userString)));
    }
    throw EmptyCacheException();
  }

  @override
  Future<Unit> removeCachedUser() async {
    final remove = await pref.remove(AppKeys.CACHED_USER);
    if (kDebugMode) {
      if (remove) {
        print('remove User');
      } else {
        print('failure');
      }
    }
    return Future.value(unit);
  }

  // @override
  // Future<Unit> cacheAuth(AuthModel authModel) async {
  //   Object authJson = authModel.toJson();
  //   final storeAuth =
  //       await pref.setString(AppKeys.CACHED_AUTH, jsonEncode(authJson));
  //   if (kDebugMode) {
  //     if (storeAuth) {
  //       print('store Auth');
  //     } else {
  //       print('failure');
  //     }
  //   }
  //   return Future.value(unit);
  // }

  // @override
  // Future<AuthModel> getCachedAuth() {
  //   final String? authString = pref.getString(AppKeys.CACHED_AUTH);
  //   if (authString != null) {
  //     if (kDebugMode) {
  //       print(authString);
  //     }
  //     return Future.value(AuthModel.fromJson(json.decode(authString)));
  //   }
  //   throw EmptyCacheException();
  // }

  // @override
  // Future<Unit> removeCachedAuth() async {
  //   final remove = await pref.remove(AppKeys.CACHED_AUTH);
  //   if (kDebugMode) {
  //     if (remove) {
  //       print('remove Auth');
  //     } else {
  //       print('failure');
  //     }
  //   }
  //   return Future.value(unit);
  // }

}
