import 'package:admin/api_package/exception_handler/exception_handler.dart';
import 'package:admin/api_package/patient_service/patient_api/patient_api.dart';
import 'package:admin/core/models/patient_model.dart';
import 'package:dio/dio.dart';

class PatientService {
  static late final PatientService instance;
  final PatientAPI patientAPI;

  PatientService({
    required this.patientAPI,
  });

  Future<List<PatientModel>> getAllPatient() async {
    try {
      final Response response = await patientAPI.getAllPatient();
      List<PatientModel> patientList = [];

      switch (response.statusCode) {
        case 200:
          for (int i = 0; i < response.data.length; i++) {
            PatientModel patientModel = PatientModel.fromMap(response.data[i]);
            patientList.add(patientModel);
          }
          
          return patientList;

        default:
          if (response.data is Map<String, dynamic>) {
            throw ExceptionHandler.fromResponse(response);
          }
          throw Exception('[${response.statusCode}].Failed to get user data.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
