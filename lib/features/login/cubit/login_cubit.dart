import 'package:admin/api_package/auth_servers/auth_api/auth.dart';
import 'package:admin/api_package/auth_servers/auth_serves.dart';
import 'package:admin/api_package/exception_handler/exception_handler.dart';
import 'package:admin/core/models/auth_login_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  AuthLoginModel? user;

  login({required String email, required String password}) async {
    try {
      user = await AuthServers(auth: Auth()).login(email, password);
      emit(LoginSuccess(message: user!.email!, token: user!.token!));
    } catch (e) {
      if (e is ExceptionHandler) {
        if (e.statusCode == 401) {
          emit(LoginInvalid());
        } else if (e.statusCode == 400) {
          emit(LoginCubitWrongPassword());
        } else {
          emit(LoginError(message: "Something went wrong. Please try again."));
        }
      }
    }
  }

  setInit() {
    emit(LoginInitial());
  }

  setCheckMemory(final String message, final String token) {
    emit(LoginCubitEnterFlashMemory(message: message, token: token));
  }

  setMemory(final String message, final String token) {
    emit(LoginCubitFlashMemory(message: message, token: token));
  }
}
