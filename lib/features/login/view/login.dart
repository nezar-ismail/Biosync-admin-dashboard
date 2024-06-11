import 'dart:developer';
import 'dart:io';
import 'package:admin/api_package/exception_handler/exception_handler.dart';
import 'package:admin/core/utils/custom_snackbar.dart';
import 'package:admin/features/doctor_controller/add_doctor/view/add_doctor.dart';
import 'package:admin/features/home/views/home_page.dart';
import 'package:admin/features/login/cubit/login_cubit.dart';
import 'package:admin/features/login/widget/login_card.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: WindowBorder(
          width: 5,
          color: Colors.black,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Expanded(
              child: Column(
                children: [
                  WindowTitleBarBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: MoveWindow(),
                        ),
                        const WindowButtons(),
                      ],
                    ),
                  ),
                  const Expanded(child: LoginBody()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is LoginSuccess) {
        log(state.token);
        bool result = readFileFromUSB("token.txt", state.token);
        if (result) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        email: state.message,
                      )));
          customSnackBar(context,
              title: 'Login Success',
              message: 'Login Success !',
              type: ContentType.success);
        } else {
          context.read<LoginCubit>().setMemory(state.message, state.token);
          customSnackBar(context,
              title: 'Something Wrong',
              message: 'Please Insert Flash Memory !',
              type: ContentType.failure);
        }
      }
      if (state is LoginCubitEnterFlashMemory) {
        bool result = readFileFromUSB("token.txt", state.token);
        if (result) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        email: state.message,
                      )));
          customSnackBar(context,
              title: 'Login Success',
              message: 'Login Success !',
              type: ContentType.success);
        } else {
          context.read<LoginCubit>().setMemory(state.message, state.token);
          customSnackBar(context,
              title: 'Something Wrong',
              message: 'Please Insert Flash Memory !',
              type: ContentType.failure);
        }
      }
      if (state is LoginError) {
        customSnackBar(context,
            title: 'Something Wrong',
            message: 'Please try again later !',
            type: ContentType.failure);
      }
      if (state is ExceptionHandler) {
        customSnackBar(context,
            title: 'Invalid',
            message: 'Invalid Email or Password !',
            type: ContentType.warning);
      }
      if (state is LoginCubitWrongPassword) {
        customSnackBar(context,
            title: 'Password Error',
            message:
                'Password must be at least 8 characters long and contain at least one letter',
            type: ContentType.failure);
      }
    }, builder: (context, state) {
      if (state is LoginCubitFlashMemory) {
        return Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<LoginCubit>().setInit();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 40,
                  ),
                ),
              ],
            ),
            Expanded(
                child: Container(
              color: Colors.white,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    bool result = readFileFromUSB("token.txt", state.token);
                    if (result) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(
                                    email: state.message,
                                  )));
                      customSnackBar(context,
                          title: 'Login Success',
                          message: 'Login Success !',
                          type: ContentType.success);
                    } else {
                      customSnackBar(context,
                          title: 'Something Wrong',
                          message: 'Please Insert Flash Memory !',
                          type: ContentType.failure);
                    }
                  },
                  icon: Lottie.asset(
                      'assets/lottie/Animation - 1717628439797.json'),
                ),
              ),
            )),
            const Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Text(
                'Please Insert Your Flash Memory Key !',
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
            ),
          ],
        );
      }
      return Expanded(child: AdminLoginCard());
    });
  }

  bool readFileFromUSB(String fileName, String token) {
    for (int i = 65; i <= 90; i++) {
      // ASCII values for 'A' to 'Z'
      String driveLetter = String.fromCharCode(i);
      try {
        String filePath = '$driveLetter:\\$fileName';
        File file = File(filePath);
        String contents = file.readAsStringSync();
        log('File Contents from $filePath:');
        log(contents);
        if (contents == token) {
          return true;
        }
      } catch (e) {
        // Continue to the next drive letter if there is an error
        continue;
      }
    }
    return false;
  }
}
