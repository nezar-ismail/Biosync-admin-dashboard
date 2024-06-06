import 'package:admin/api_package/API/api.dart';
import 'package:admin/core/models/constant.dart';
import 'package:dio/dio.dart';

class Delete extends API {
  Future<Response> deleteDoctor(String id) async {
    const String url = '${Constants.ipAddress}doctor/delete/';

    try {
      Response response = await delete(url + id);
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> deleteUser(String id) async {
    const String url = '${Constants.ipAddress}user/delete/';

    try {
      Response response = await delete(url + id);
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }
}
