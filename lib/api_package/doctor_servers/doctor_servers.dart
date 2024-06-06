import 'dart:developer';
import 'package:admin/api_package/doctor_servers/doctor_api/doctor_api.dart';
import 'package:admin/api_package/exception_handler/exception_handler.dart';

import 'package:admin/core/models/doctor_model.dart';
import 'package:dio/dio.dart';

class DoctorService {
  static late final DoctorService instance;
  final DoctorAPI doctor;

  DoctorService({
    required this.doctor,
  });

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
    try {
      Response response = await doctor.createDoctor(doctorname, doctoremail,
          password, specialization, about, phone, gender, experience, workdays);

      switch (response.statusCode) {
        case 201:
          return response;
        case 401:
          throw ExceptionHandler.fromResponse(response);
        case 409:
          throw ExceptionHandler.fromResponse(response);
        case 400:
          if (response.data["message"] == "Invalid email address.") {
            throw ExceptionHandler.fromResponse(response);
          } else {
            throw ExceptionHandler.fromResponse(response);
          }
        default:
          throw ExceptionHandler.fromResponse(response);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> updateDoctorInfo(
      int id,
      String doctorname,
      String specialization,
      String about,

      String gender,
      int experience,
      Map<String, dynamic> workdays) async {
    try {
      Response response = await doctor.updateDoctorInfo(id, doctorname,
          specialization, about,  gender, experience, workdays);
      switch (response.statusCode) {
        case 201:
          return response;

        case 404:
          throw ExceptionHandler.fromResponse(response);
        default:
          throw ExceptionHandler.fromResponse(response);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<DoctorModel>> getAllDoctor() async {
    try {
      final Response response = await doctor.getAllDoctor();

      switch (response.statusCode) {
        case 200:
          // success
          final data = response.data as List<dynamic>;
          List<DoctorModel> doctorList = [];
          DoctorModel doctorModel;

          for (int i = 0; i < data.length; i++) {
            doctorModel = DoctorModel.fromMap(data[i]);
            // LocalDoctorModel localDoctorModel = storeLocalModel(doctorModel, i);
            doctorList.add(doctorModel);
            // LocalDoctorModelService.addOrUpdateDoctor(localDoctorModel);
          }

          return doctorList;

        default:
          if (response.data is Map<String, dynamic>) {
            throw ExceptionHandler.fromResponse(response);
          }
          throw Exception('[${response.statusCode}].Failed to sign in.');
      }
    } catch (e) {
      log(e.toString());
      rethrow; // Rethrow the exception to propagate it further if needed.
    }
  }

  Future<DoctorModel> getDoctorById({required int id}) async {
    try {
      final Response response = await doctor.getDoctorById(id: id);

      switch (response.statusCode) {
        case 201:
          // success
          final data = response.data as Map<String, dynamic>;
          DoctorModel doctorModel = DoctorModel.fromMap(data);

          return doctorModel;

        default:
          if (response.data is Map<String, dynamic>) {
            throw ExceptionHandler.fromResponse(response);
          }
          throw Exception('[${response.statusCode}].Failed to sign in.');
      }
    } catch (e) {
      log(e.toString());
      rethrow; // Rethrow the exception to propagate it further if needed.
    }
  }

  Future<Response> deleteDoctorById({required int id}) async {
    try {
      Response response = await doctor.deleteDoctorById(id: id);
      switch (response.statusCode) {
        case 201:
          return response;

        case 404:
          throw ExceptionHandler.fromResponse(response);

        default:
          throw ExceptionHandler.fromResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deletePatientById({required int id}) async {
    try {
      Response response = await doctor.deletePatientById(id: id);
      switch (response.statusCode) {
        case 200:
          return response;

        case 404:
          throw ExceptionHandler.fromResponse(response);

        default:
          throw ExceptionHandler.fromResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }
  // Future<String> updateDoctorPassword(
  //     String id, String oldpassword, String newpassword) async {
  //   try {
  //     Response response =
  //         await doctor.updateDoctorPassword(id, oldpassword, newpassword);
  //     switch (response.statusCode) {
  //       case 201:
  //         return "Password Updated Successfully";

  //       case 401:
  //         return "Incorrect password";

  //       case 404:
  //         return "Doctor not found";

  //       case 400:
  //         if (response.data["message"] ==
  //             "Old password must be at least 8 characters long and contain at least one letter.") {
  //           return "Old password must be at least 8 characters long and contain at least one letter.";
  //         } else {
  //           return "New password must be at least 8 characters long and contain at least one letter.";
  //         }

  //       default:
  //         return "Error while updating password";
  //     }
  //   } on DioException {
  //     return "Error while updating password";
  //   }
  // }
}
