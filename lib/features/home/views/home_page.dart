import 'package:admin/features/doctor_controller/add_doctor/view/add_doctor.dart';
import 'package:admin/features/doctor_controller/doctor_info/view/info_right_side.dart';
import 'package:admin/features/doctor_controller/edit_doctor/view/edit_doctor_right.dart';
import 'package:admin/features/home/cubit/admin_cubit.dart';

import 'package:admin/features/doctor_controller/view/doctor_right_side.dart';
import 'package:admin/features/home/widget/left_side.dart';
import 'package:admin/features/home/widget/right_side.dart';
import 'package:admin/features/patient_controller/views/patient_right_side.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.email,
  });
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowBorder(
        width: 5,
        color: const Color.fromARGB(255, 0, 0, 0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Expanded(
            child: Row(
              children: [
                const LeftSide(),
                BlocBuilder<AdminCubit, AdminCubitState>(
                  builder: (context, state) {
                    if (state is PatientCubitLoaded) {
                      return PatientRightSide(
                        patient: state.patientInfo,
                      );
                    }
                    if (state is DoctorCubitLoaded) {
                      return DoctorRightSide(
                        doctor: state.doctorInfo,
                      );
                    }
                    if (state is AdminCubitEditDoctor) {
                      return EditDoctorRightSide(
                        doctor: state.doctorInfo!,
                      );
                    }
                    if (state is EditDoctorCubitSuccess) {
                      return HomeRightSide(
                        email: email,
                      );
                    }
                    if (state is AdminCubitAddDoctor) {
                      return const AddDoctorRightSide();
                    }
                    if (state is AdminCubitViewDoctor) {
                      return ViewDoctorRightSide(
                        doctor: state.doctorInfo,
                      );
                    }

                    return HomeRightSide(
                      email: email,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
