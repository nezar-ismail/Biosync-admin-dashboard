part of 'admin_cubit.dart';

sealed class AdminCubitState {}

final class AdminCubitInitial extends AdminCubitState {}

final class AdminCubitControlDoctor extends AdminCubitState {}

final class AdminCubitViewDoctor extends AdminCubitState {
  final DoctorModel? doctorInfo;
  AdminCubitViewDoctor(this.doctorInfo);
}

final class AdminCubitControlPatient extends AdminCubitState {}

final class AdminCubitAddDoctor extends AdminCubitState {}

final class AdminCubitEditDoctor extends AdminCubitState {
  DoctorModel? doctorInfo;
  AdminCubitEditDoctor(this.doctorInfo);
}

final class DoctorCubitLoaded extends AdminCubitState {
  final List<DoctorModel> doctorInfo;
  DoctorCubitLoaded(this.doctorInfo);
}

final class DoctorCubitError extends AdminCubitState {
  final String message;
  DoctorCubitError(this.message);
}

final class PatientCubitLoaded extends AdminCubitState {
  final List<PatientModel> patientInfo;
  PatientCubitLoaded(this.patientInfo);
}

final class PatientCubitError extends AdminCubitState {
  final String message;
  PatientCubitError(this.message);
}

final class CreateDoctorCubitSuccess extends AdminCubitState {}

final class EditDoctorCubitSuccess extends AdminCubitState {}

final class DoctorDeleteError extends AdminCubitState {}

final class PatientDeleteError extends AdminCubitState {}

final class InvalidUserNameCubit extends AdminCubitState {}

final class InvalidPhoneCubit extends AdminCubitState {}

final class ErrorInCreateDoctorCubit extends AdminCubitState {}
