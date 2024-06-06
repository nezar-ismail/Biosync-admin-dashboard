import 'package:admin/core/utils/custom_snackbar.dart';
import 'package:admin/features/doctor_controller/add_doctor/widget/dortor_form_widget/coustom_text_field.dart';
import 'package:admin/features/login/cubit/login_cubit.dart';
import 'package:admin/features/login/widget/custom_gradient_button.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:login/core/route.dart';
// import 'package:login/features/auth/cubit/cubit/auth_cubit.dart';

class AdminLoginCard extends StatelessWidget {
  AdminLoginCard({
    super.key,
  });
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 25, left: 25, bottom: 70, top: 70),
          child: Container(
            height: 600,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 149, 149, 149),
                  offset: Offset(1, 1),
                  blurRadius: 15,
                  spreadRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 280,
                  child: Image.asset('assets/images/logo.png'),
                ),
                const SizedBox(
                  height: 80,
                ),
                CustomTextField(
                  hintText: 'Email',
                  icon: Icons.email,
                  myController: _emailController,
                ),
                CustomTextField(
                  hintText: 'Password',
                  icon: Icons.lock,
                  myController: _passwordController,
                  pass: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: GradientButton(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade900,
                        Colors.green,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    onPressed: () {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        var authCubit = BlocProvider.of<LoginCubit>(context);

                        authCubit.login(
                            email: _emailController.text,
                            password: _passwordController.text);
                      } else {
                        customSnackBar(
                          context,
                          title: 'Required Field',
                          message: 'All field are required !',
                          type: ContentType.warning,
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(50),
                    height: 60,
                    width: 180,
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
