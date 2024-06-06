import 'package:admin/api_package/doctor_servers/doctor_api/doctor_api.dart';
import 'package:admin/api_package/doctor_servers/doctor_servers.dart';
import 'package:admin/api_package/exception_handler/exception_handler.dart';
import 'package:admin/api_package/patient_service/patient_api/patient_api.dart';
import 'package:admin/api_package/patient_service/patient_service.dart';
import 'package:admin/core/models/doctor_model.dart';
import 'package:admin/core/models/patient_model.dart';
import 'package:dio/dio.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_cubit_state.dart';

class AdminCubit extends Cubit<AdminCubitState> {
  AdminCubit() : super(AdminCubitInitial());
  List<DoctorModel> doctors = [];
  List<PatientModel> patients = [];

  addDoctor() {
    emit(AdminCubitAddDoctor());
  }

  editDoctor({required DoctorModel doctor}) {
    emit(AdminCubitEditDoctor(doctor));
  }

  viewDoctor({required DoctorModel doctor}) {
    emit(AdminCubitViewDoctor(doctor));
  }

  Future<void> getAllDoctorInfo() async {
    try {
      doctors = await DoctorService(doctor: DoctorAPI()).getAllDoctor();
      emit(DoctorCubitLoaded(doctors));
    } catch (e) {
      emit(DoctorCubitError(e.toString()));
    }
  }

  Future<void> getAllPatientInfo() async {
    try {
      patients = await PatientService(patientAPI: PatientAPI()).getAllPatient();

      emit(PatientCubitLoaded(patients));
    } catch (e) {
      emit(PatientCubitError(e.toString()));
    }
  }

  Future<void> deleteDoctor(int id) async {
    try {
      // ignore: unused_local_variable
      Response response =
          await DoctorService(doctor: DoctorAPI()).deleteDoctorById(id: id);
      doctors.removeWhere((doctor) => doctor.id == id);
      emit(DoctorCubitLoaded(doctors));
    } catch (e) {
      emit(DoctorDeleteError());
    }
  }

  Future<void> deletePatient(int id) async {
    try {
      // ignore: unused_local_variable
      Response response =
          await DoctorService(doctor: DoctorAPI()).deletePatientById(id: id);
      patients.removeWhere((patient) => patient.id == id);
      emit(PatientCubitLoaded(patients));
    } catch (e) {
      emit(PatientDeleteError());
    }
  }

  editDoctorInfo(
      {required int id,
      required String doctorname,
      required String specialization,
      required String about,
      required String gender,
      required int experience,
      required Map<String, dynamic> workdays}) async {
    try {
      await DoctorService(doctor: DoctorAPI()).updateDoctorInfo(
        id,
        doctorname,
        specialization,
        about,
        gender,
        experience,
        workdays,
      );

      emit(EditDoctorCubitSuccess());
    } catch (e) {
      if (e is ExceptionHandler) {
        if (e.statusCode == 400) {
          if (e.message ==
              "Username Must be at least 3 characters long and contain only letters.") {
            emit(InvalidUserNameCubit());
          } else {
            emit(ErrorInCreateDoctorCubit());
          }
        } else {
          emit(ErrorInCreateDoctorCubit());
        }
      }
    }
  }
}
