part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String message;
  final String token;

  LoginSuccess({required this.message, required this.token});
}

final class LoginCubitFlashMemory extends LoginState {
  final String message;
  final String token;

  LoginCubitFlashMemory({required this.message, required this.token});
}
final class LoginCubitEnterFlashMemory extends LoginState {
    final String message;
  final String token;

  LoginCubitEnterFlashMemory({required this.message, required this.token});
}
final class LoginCubitWrongPassword extends LoginState {}

final class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}

final class LoginInvalid extends LoginState {}
