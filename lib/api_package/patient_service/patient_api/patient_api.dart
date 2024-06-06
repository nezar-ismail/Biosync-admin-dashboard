import 'package:admin/api_package/API/api.dart';
import 'package:admin/core/models/constant.dart';
import 'package:dio/dio.dart';

class PatientAPI extends API {
  Future<Response> getAllPatient() async {
    const String url = '${Constants.ipAddress}user/getall';

    final Response response = await get(url);

    return response;
  }
}
