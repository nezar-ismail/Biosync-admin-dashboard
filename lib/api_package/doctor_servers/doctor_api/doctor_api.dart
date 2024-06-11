import 'dart:developer';

import 'package:admin/api_package/API/api.dart';
import 'package:admin/core/models/constant.dart';
import 'package:dio/dio.dart';

class DoctorAPI extends API {
  Future<Response> createDoctor(
      String doctorname,
      String doctoremail,
      String password,
      String specialization,
      String about,
      String phone,
      String gender,
      int experience,
      Map<String, dynamic> workdays) async {
    const String url = '${Constants.ipAddress}doctor/register';
    final Map<String, dynamic> body = {
      'doctorname': doctorname,
      'doctoremail': doctoremail,
      'password': password,
      'specialization': specialization,
      'about': about,
      'phone': phone,
      'gender': gender,
      'experience': experience,
      'workday': workdays
    };
    Response response = await post(url, body: body);
    return response;
  }

  Future<Response> updateDoctorInfo(
      int id,
      String doctorname,
      String specialization,
      String about,
      String gender,
      int experience,
      Map<String, dynamic> workdays) async {
    String url = '${Constants.ipAddress}doctor/edit/$id';
    try {
      Response response = await put(url,
          body: Map<String, dynamic>.from({
            'doctorname': doctorname,
            'specialization': specialization,
            'about': about,
            'gender': gender,
            'experience': experience,
            'workday': workdays
          }));
      log(response.data.toString());
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> getAllDoctor() async {
    const String url = '${Constants.ipAddress}doctor/getall';

    final Response response = await get(url);
    return response;
  }

  Future<Response> getDoctorById({required int id}) async {
    String url = '${Constants.ipAddress}doctor/$id';

    final Response response = await get(url);
    return response;
  }

  Future<Response> deleteDoctorById({required int id}) async {
    String url = '${Constants.ipAddress}doctor/delete/$id';

    final Response response = await delete(url);
    return response;
  }

  Future<Response> deletePatientById({required int id}) async {
    String url = '${Constants.ipAddress}user/delete/$id';

    final Response response = await delete(url);
    return response;
  }

  // Future<Response> updateDoctorPassword(
  //     String id,  String oldpassword , String newpassword) async {
  //   const String url = 'http://10.0.2.2:5000/doctor/password/';

  //   try {
  //     Response response = await put(url + id, body: Map<String, dynamic>.from({
  //       'oldpassword' : oldpassword,
  //       'newpassword' : newpassword
  //     }));

  //     return response;
  //   } on DioException catch (e) {
  //     return e.response!;
  //   }
  // }
}
