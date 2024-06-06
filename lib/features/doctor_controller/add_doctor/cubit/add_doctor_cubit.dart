import 'package:admin/api_package/doctor_servers/doctor_api/doctor_api.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:admin/api_package/doctor_servers/doctor_servers.dart';
import 'package:admin/api_package/exception_handler/exception_handler.dart';
import 'package:admin/core/models/doctor_edit_model.dart';

part 'add_doctor_state.dart';

class AddDoctorCubit extends Cubit<AddDoctorState> {
  AddDoctorCubit() : super(AddDoctorInitial());
  Response? doctor;
  DoctorEditModel? doctorInfo;
  createDoctor(
      {required String doctorname,
      required String doctoremail,
      required String password,
      required String specialization,
      required String about,
      required String phone,
      required String gender,
      required int experience,
      required Map<String, dynamic> workdays}) async {
    try {
      doctor = await DoctorService(doctor: DoctorAPI()).createDoctor(
          doctorname,
          doctoremail,
          password,
          specialization,
          about,
          phone,
          gender,
          experience,
          workdays);
      emit(CreateDoctorCubitSuccess());
    } catch (e) {
      if (e is ExceptionHandler) {
        if (e.statusCode == 409) {
          emit(AlreadyExistsCubit());
        } else if (e.statusCode == 400) {
          if (e.message == "Invalid email address.") {
            emit(InvalidEmailCubit());
          } else if (e.message ==
              "Password must be at least 8 characters long and contain at least one letter.") {
            emit(InvalidPasswordCubit());
          } else {
            emit(ErrorInCreateDoctorCubit());
          }
        } else if (e.statusCode == 401) {
          emit(InvalidPhoneCubit());
        } else {
          emit(ErrorInCreateDoctorCubit());
        }
      }
    }
  }
}
