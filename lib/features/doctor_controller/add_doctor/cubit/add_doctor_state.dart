part of 'add_doctor_cubit.dart';

@immutable
sealed class AddDoctorState {}

final class AddDoctorInitial extends AddDoctorState {}

final class CreateDoctorCubitSuccess extends AddDoctorState {}

final class EditDoctorCubitSuccess extends AddDoctorState {}


final class AlreadyExistsCubit extends AddDoctorState {}

final class InvalidEmailCubit extends AddDoctorState {}

final class InvalidPhoneCubit extends AddDoctorState {}

final class InvalidUserNameCubit extends AddDoctorState {}

final class InvalidPasswordCubit extends AddDoctorState {}

final class CreateDoctorCubitError extends AddDoctorState {}

final class ErrorInCreateDoctorCubit extends AddDoctorState {}

class AddDoctorDayToggled extends AddDoctorState {
  final Map<String, bool> workDays;

  AddDoctorDayToggled(this.workDays);
}
