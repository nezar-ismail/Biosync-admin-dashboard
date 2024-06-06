// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:admin/api_package/auth_servers/auth_api/auth.dart';
import 'package:admin/api_package/exception_handler/exception_handler.dart';
import 'package:admin/core/models/auth_login_model.dart';
import 'package:dio/dio.dart';

class AuthServers {
  static late final AuthServers instance;
  final Auth auth;
  AuthLoginModel? authLoginModel;

  AuthServers({
    required this.auth,
    this.authLoginModel,
  });

  Future<AuthLoginModel> login(String email, String password) async {
    try {
      Response response = await auth.signIn(email, password);

      switch (response.statusCode) {
        case 201:
          authLoginModel = AuthLoginModel.fromMap(response.data);
          return authLoginModel!;

        case 400:
          throw ExceptionHandler.fromResponse(response);

        case 401:
          throw ExceptionHandler.fromResponse(response);

        default:
          throw ExceptionHandler.fromResponse(response);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
