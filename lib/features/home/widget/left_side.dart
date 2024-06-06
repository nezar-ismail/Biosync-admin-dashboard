// ignore_for_file: deprecated_member_use

import 'package:admin/features/home/cubit/admin_cubit.dart';
import 'package:admin/core/utils/dash_button.dart';
import 'package:admin/features/login/view/login.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeftSide extends StatelessWidget {
  const LeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    Color color1 = const Color.fromARGB(255, 255, 255, 255);
    Color color2 = const Color.fromARGB(255, 255, 255, 255);
    Color color3 = const Color.fromARGB(255, 255, 255, 255);

    return SizedBox(
      width: 300,
      child: BlocConsumer<AdminCubit, AdminCubitState>(
        listener: (context, state) {
          if (state is DoctorCubitLoaded) {
            color1 = Colors.green;
            color2 = const Color.fromARGB(255, 255, 255, 255);
            color3 = const Color.fromARGB(255, 255, 255, 255);
          }
          if (state is PatientCubitLoaded) {
            color1 = const Color.fromARGB(255, 255, 255, 255);
            color2 = Colors.green;
            color3 = const Color.fromARGB(255, 255, 255, 255);
          }
          if (state is AdminCubitAddDoctor) {
            color1 = const Color.fromARGB(255, 255, 255, 255);
            color2 = const Color.fromARGB(255, 255, 255, 255);
            color3 = Colors.green;
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.teal.shade50,
                  Colors.teal.shade100,
                  Colors.teal.shade200,
                  Colors.teal.shade300,
                  Colors.teal.shade400,
                  Colors.teal.shade500,
                  Colors.teal.shade600,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                WindowTitleBarBox(
                  child: MoveWindow(),
                ),
                const Logo(),
                const Spacer(
                  flex: 1,
                ),
                DashButton(
                  onPressed: () {
                    context.read<AdminCubit>().getAllDoctorInfo();
                  },
                  text: "Doctor's Controller",
                  color: color1,
                  icon: FontAwesomeIcons.userDoctor,
                ),
                const Spacer(
                  flex: 1,
                ),
                DashButton(
                  onPressed: () {
                    context.read<AdminCubit>().getAllPatientInfo();
                  },
                  text: "Patient's Controller",
                  color: color2,
                  icon: FontAwesomeIcons.userLarge,
                ),
                const Spacer(
                  flex: 15,
                ),
                DashButton(
                  onPressed: () {
                    context.read<AdminCubit>().addDoctor();
                  },
                  text: "Add Doctor",
                  color: color3,
                  icon: FontAwesomeIcons.add,
                ),
                const Spacer(
                  flex: 1,
                ),
                DashButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: const Text("Are you sure you want to log out?"),
                            actions: [
                              TextButton(
                                  child: const Text("Yes"),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginView()));
                                  }),
                              TextButton(
                                child: const Text("No"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    text: "Log Out",
                    color: color3,
                    icon: FontAwesomeIcons.signOut),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.15,
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
