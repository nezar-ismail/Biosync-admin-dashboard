// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:admin/core/models/doctor_model.dart';

import 'package:admin/features/doctor_controller/doctor_info/widgets/check_days.dart';
import 'package:admin/features/doctor_controller/doctor_info/widgets/doctor_about.dart';
import 'package:admin/features/doctor_controller/doctor_info/widgets/reviews_info.dart';

import 'package:flutter/material.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({
    super.key,
    required this.doctor,
  });
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 0),
      child: Column(
        children: [
          ///  container for gradient
          ///
          Container(
            height: MediaQuery.sizeOf(context).height * 0.15,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.teal,
                Colors.teal.shade300,
                Colors.teal.shade400,
              ]),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 147, 147, 147),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 5), // changes position of shadow
                )
              ],
              color: Colors.teal,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: Center(
                  child: Text(
                    'Dr.${doctor.doctorname}',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontSize:
                            MediaQuery.textScalerOf(context).textScaleFactor *
                                30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              )
            ]),
          ),

          ///  image and specialization
          ///
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.15,
            left: MediaQuery.sizeOf(context).width / 2 - 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: MediaQuery.textScalerOf(context).textScaleFactor * 50,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    'http://192.168.1.106:5000${doctor.image}',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),

                /// Specialization
                ///
                Text(
                  doctor.specialization.toUpperCase(),
                  style: TextStyle(
                      fontSize:
                          MediaQuery.textScalerOf(context).textScaleFactor * 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54),
                ),
              ],
            ),
          ),

          ///  Reviews  And Experience
          ///
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.15,
            left: MediaQuery.sizeOf(context).width / 2 - 160,
            child: ReviewsInfo(
              doctor: doctor,
            ),
          ),

          ///  About
          ///
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.25,
            left: 0,
            child: DoctorAbout(doctor: doctor),
          ),

          ///  Check Days
          ///
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.35,
            left: MediaQuery.sizeOf(context).width * 0.5,
            child: ListDays(
              doctor: doctor,
            ),
          ),
        ],
      ),
    );
  }
}
