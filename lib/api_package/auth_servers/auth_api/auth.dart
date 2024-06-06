import 'package:admin/api_package/API/api.dart';
import 'package:admin/core/models/constant.dart';
import 'package:dio/dio.dart';

class Auth extends API {
  Future<Response> signIn(String email, String password) async {
    // Construct the URL for the signIn request.
    const String url = '${Constants.ipAddress}admin/login';

    // Construct the body for the signIn request.
    final Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    // Send a POST request to the server and await the response.
    final Response response = await post(
      url,
      body: body,
    );

    return response;
  }
}
